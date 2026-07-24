class MessagesController < ApplicationController
  SYSTEM_PROMT = "You are a helpful medical assistant specializing in medicine and geriatric care.\n
   I am a eldery patient who seeking help about my medication.\n
   Help me understand my medication in simple, non technical language.\n Answer in simple plain text.\n"

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @chats = current_user.chats
    @medication = @chat.medication

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = set_role

    if @message.save
      @assistant_message = @chat.messages.create(role: "assistant", content: "")
      @llm = RubyLLM.chat
      @llm.with_instructions(instructions)
      chat_history

      response = @llm.ask(@message.content) do |chunk|
        next if chunk.content.blank?

        @assistant_message.content += chunk.content
        broadcast_replace(@assistant_message)
      end

      @assistant_message.update(content: response.content)
      broadcast_replace(@assistant_message)

      @chat.generate_title_from_first_message

      Turbo::StreamsChannel.broadcast_update_to(
        @chat,
        target: helpers.dom_id(@chat, :title),
        html: @chat.title
      )

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            :new_message_container,
            partial: "messages/form",
            locals: { chat: @chat, message: @message }
          )
        end
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_role
    @message.role = @family_member.present? ? "family_member" : "user"
  end

  def medication_name
    @medication.name
  end

  def chat_history
    @chat.messages.each do |message|
      next if message.content.blank?

      @llm.add_message(role: message.role, content: message.content)
    end
  end

  def instructions
    [SYSTEM_PROMT, medication_name].compact.join("\n\n")
  end

  def broadcast_replace(message)
    Turbo::StreamsChannel.broadcast_replace_to(
      @chat,
      target: helpers.dom_id(message),
      partial: "messages/message",
      locals: { message: message }
    )
  end
end

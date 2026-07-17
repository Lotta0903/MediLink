class MessagesController < ApplicationController
  SYSTEM_PROMT = "You are a helpful medical assistant specializing in medicine and geriatric care.\n
   I am a eldery patient who seeking help about my medication.\n
   Help me understand my medication in simple, non technical language.\n Answer in simple plain text.\n"

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @medication = @chat.medication

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = set_role

    if @message.save
      @llm = RubyLLM.chat
      @llm.with_instructions(instructions)
      chat_history
      response = @llm.ask(@message.content)

      Message.create(role: "assistant", content: response.content, chat: @chat)

      @chat.generate_title_from_first_message

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
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
      @llm.add_message(role: message.role, content: message.content)
    end
  end

  def instructions
    [SYSTEM_PROMT, medication_name].compact.join("\n\n")
  end
end

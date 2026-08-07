class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are a medical information specialist assisting elderly users with general medical inquiries.
Provide clear, accurate, and easy to understand general medical information.
Answer the user's question directly, including the information that is most relevant to their request.
For medicines, include helpful details such as what it is, why it is used, common forms, general safety information, and important considerations when relevant.
Keep explanations simple, calm, and non clinical.
If a user asks for advice specific to their own health, explain that your information is general in nature and encourage them to consult a healthcare professional.
Respond in plain language suitable for elderly users.
Format responses using Markdown with clear headings and bullet points.
Keep responses clear and easy to read.
Provide enough detail to answer the question properly."

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @chats = current_user.chats
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      response = ask_llm

      @assistant_message = @chat.messages.create(role: "assistant", content: response)
      @chat.generate_title_from_first_message

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      render_form_errors
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def ask_llm
    ruby_llm_chat = RubyLLM.chat
    ruby_llm_chat.with_instructions(system_instructions)
    build_conversation_history(ruby_llm_chat)

    response = ruby_llm_chat.ask(@message.content)
    response.content
  end

  def build_conversation_history(ruby_llm_chat)
    @chat.messages.each do |message|
      next if message.content.blank?
      ruby_llm_chat.add_message(role: message.role, content: message.content)
    end
  end

  def system_instructions
    medication_info = "Here is the name of the user's medication: #{@chat.medication.name}"
    [SYSTEM_PROMPT, medication_info].join("\n\n")
  end

  def broadcast_replace(message)
    Turbo::StreamsChannel.broadcast_replace_to(
      @chat,
      target: helpers.dom_id(message),
      partial: "messages/message",
      locals: { message: message }
    )
  end

  def render_form_errors
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

class ChatsController < ApplicationController
  def create
    @medication = Medication.find(params[:medication_id])
    @chat = Chat.new(title: "Untitled")
    @chat.medication = @medication
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      render "medication/show"
    end
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @medication = @chat.medication
    @message = Message.new
    @chats = @medication.chats
  end
end

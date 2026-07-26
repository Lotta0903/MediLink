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

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chats_path }
    end
  end
end

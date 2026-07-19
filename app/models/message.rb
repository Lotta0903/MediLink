class Message < ApplicationRecord
  belongs_to :chat
  MAX_USER_MESSAGES = 10

  after_create_commit :broadcast_append_to_chat

  validate :max_user_messages, if: -> { role == "user" }

  def max_user_messages
    return unless chat.messages.where(role: "user").count >= MAX_USER_MESSAGES

    errors.add(:content, "You can only send #{MAX_USER_MESSAGES} per chat")
  end

  private

  def broadcast_append_to_chat
    broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { message: self }
  end
end

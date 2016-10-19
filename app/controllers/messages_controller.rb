class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    render json: @conversation.messages
  end

  def create
    respond_with @conversation.messages.create(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end

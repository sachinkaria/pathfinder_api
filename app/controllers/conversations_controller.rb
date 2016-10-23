class ConversationsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @conversations = []
    @conversations.push(Conversation.where(sender_id: current_user.id))
    @conversations.push(Conversation.where(recipient_id: current_user.id))
    render json: @conversations.flatten
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id])
      .present?
      @conversation = Conversation.between(params[:sender_id],
      params[:recipient_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end
    respond_with @conversation
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end

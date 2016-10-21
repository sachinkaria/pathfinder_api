class UsersController < ApplicationController
before_action :authenticate_user!
respond_to :json

  def show
    render json: User.find(params[:id])
  end

  def index
    render json: User.all
  end

end

class UsersController < ApplicationController
before_action :authenticate_user!
respond_to :json

  def show
    @user = current_user.posts
    render json: @user
  end

  def index
    render json: User.all
  end

end

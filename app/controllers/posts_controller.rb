class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Post.all
  end

  def create
    respond_with current_user.posts.create(post_params)
  end

  private

  def post_params
    params.permit(:description)
  end

end

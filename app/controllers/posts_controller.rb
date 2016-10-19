class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Post.all
  end

  def create
    respond_with current_user.posts.create(post_params)
  end

  def show
    render json: Post.find(params[:id])
  end

  def update
     respond_with Post.find(params[:id]).update(post_params)
  end

  def destroy
     Post.find(params[:id]).destroy
  end

  private

  def post_params
    params.permit(:description)
  end

end

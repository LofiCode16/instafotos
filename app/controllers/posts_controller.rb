class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path, notice: 'El post fue creado con éxito!'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, notice: 'La publicación fue eliminada'
  end

  private
  def post_params
    params.require(:post).permit(:image_url, :content)
  end
end

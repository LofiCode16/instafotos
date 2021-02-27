class PostsController < ApplicationController
  def index
    @posts = Post.posts_for_me(current_user.friends)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to root_path, notice: 'El post fue creado con éxito!'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    if @post.user == current_user
      @post.destroy
      redirect_to root_path, notice: 'La publicación fue eliminada'
    else
      redirect_to root_path, alert: 'No puedes eliminar una publicación que no es tuya'
    end
  end

  private
  def post_params
    params.require(:post).permit(:image_url, :content)
  end
end

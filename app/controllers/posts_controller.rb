class PostsController < ApplicationController
  def index
    @posts = Post.posts_for_me(current_user.friends).page(params[:page])
    @posts = Post.all.page(params[:page]) if params[:explore]
    @posts = Post.where(user_id: params[:friend_id]).page(params[:page]) if params[:friend_id]
    @posts = Post.where(user_id: params[:id]).page(params[:page]) if params[:id]
    @posts = Post.where('content LIKE ?', "%#{params[:q]}%").page(params[:page]) if params[:q]
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

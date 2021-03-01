class PostsController < ApplicationController
  def index
    @posts = Post.posts_for_me(current_user.friends).page(params[:page])
    @posts = Post.explore.page(params[:page]) if params[:explore]
    @posts = Post.friend_posts(params[:id]).page(params[:page]) if params[:id]
    @posts = Post.search_post(params[:q]).page(params[:page]) if params[:q]
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to root_path, notice: 'El post fue creado con éxito!'
    else
      redirect_to root_path, alert: 'No se ha podido crear la publicación, revisa los campos del formulario'
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

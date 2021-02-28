class RepostsController < ApplicationController

    def new
        @repost = Post.new
        @post = Post.find(params[:id])
    end

    def create
        @repost = Post.new(repost_params)
        @repost.user = current_user

        if @repost.save
            redirect_to root_path, notice: 'Publicación compartida'
        else
            redirect_to root_path, alert: 'No se ha podido compartir la publicación'
        end
    end

    private
    def repost_params
        params.require(:post).permit(:content, :repost_id)
    end

end
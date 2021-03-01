class Api::ApiController < ActionController::API
    before_action :authenticate_user!, only: [:index, :create]

    def index
        @posts = Post.posts_for_me(current_user.friends)

        render json: @posts
    end

    def explore
        @posts = Post.explore

        render json: @posts
    end

    def date
        @posts = Post.where(
            'created_at BETWEEN ? AND ?',
            params[:date_1].to_date.beginning_of_day,
            params[:date_2].to_date.end_of_day
        )

        render json: @posts
    end

    def create
        @post = Post.new(
            image_url: params[:image_url],
            content: params[:content],
            user_id: current_user.id
        )

        if @post.save
            render json: { message: 'El post ha sido creado'}
        else
            render json: { error: 'No se pudo crear el post' }
        end
    end
end
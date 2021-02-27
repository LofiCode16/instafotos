class FriendsController < ApplicationController
  def create
    @friend = User.find(params[:friend_id])
    
    @friendship = Friend.new(
                user_id: current_user.id,
                friend_id: @friend.id
              )

    current_user.friends << @friendship

    redirect_to root_path, notice: "Ahora estás siguiendo a #{@friend.name}"
  end

  def destroy
    @friend = User.find(params[:friend_id])
    @friendship = Friend.find_by(user_id: current_user.id, friend_id: @friend.id)

    @friendship.destroy

    redirect_to root_path, notice: "Dejaste de seguir a #{@friend.name}"
  end
end

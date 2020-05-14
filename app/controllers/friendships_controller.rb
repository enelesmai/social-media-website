class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:user])
    current_user.request_friendship @friend
    redirect_to request.referrer, notice: 'Friendship request submitted'
  end
end

class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:user])
    current_user.request_friendship @friend
    redirect_to request.referrer, notice: 'Friendship request submitted'
  end

  def update
    @friendship = Friendship.find(params[:id])
    @user = User.find(params[:user])

    if params[:confirmed] == 'true'
        current_user.confirm_friendship(@user)
        flash.notice = "Friendship with #{@user.name} was accepted"
    else
      @friendship.destroy
      flash.alert = "Friendship with #{@user.name} was declined"
    end
    redirect_to request.referrer
  end
end

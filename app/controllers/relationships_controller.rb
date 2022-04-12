class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    following = current_user.follow(params[:user_id])
    flash[:notice] = if following.save
                       'ユーザーをフォローしました'
                     else
                       'ユーザーのフォローに失敗しました'
                     end
    redirect_to request.referer
  end

  def destroy
    following = current_user.unfollow(params[:user_id])
    flash[:notice] = if following.destroy
                       'ユーザーのフォローを解除しました'
                     else
                       'ユーザーのフォロー解除に失敗しました'
                     end
    redirect_to request.referer
  end

end

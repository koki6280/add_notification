class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @diary = Diary.find(params[:diary_id])
    favorite = @diary.favorites.new(user_id: current_user.id)
    favorite.save
    @diary.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = @diary.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end



end

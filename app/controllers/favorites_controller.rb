class FavoritesController < ApplicationController
	before_action :authenticate_user!
  
  def create
    @diary = Diary.find(params[:diary_id])
    favorite = @diary.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = @diary.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end
end

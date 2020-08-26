class FavoritesController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id])
    favorite = @diary.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = @diary.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end



end

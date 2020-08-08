class DiariesController < ApplicationController

	def new
		@diary = Diary.new
	end

	def create
		@diary = Diary.new(diary_params)
		@diary.user_id = current_user.id
		@diary.save
		redirect_to user_path(current_user)
	end

	def index
		@diaries = Diary.all
	end

	def show
		@diary = Diary.find(params[:id])
	end

	def edit
		@diary = Diary.find(params[:id])
	end

	def update
		@diary = Diary.find(params[:id])
		@diary.update(diary_params)
		redirect_to user_path(current_user)
	end

	def destroy
		@diary = Diary.find(params[:id])
		@diary.destroy
		redirect_to user_path(current_user)
	end

	private

	def diary_params
		params.require(:diary).permit(:body, :body_image, :exercise, :sleep, :cigarette, :drinking)
	end
end

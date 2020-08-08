class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to user_path(current_user)
	end

	private

	def user_params
        params.require(:user).permit(:nickname, :profile, :profile_image)
    end
end

class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries
		days = (Date.today.beginning_of_month..Date.today).to_a
		diaries = days.map { |item| Diary.where(created_at: item.beginning_of_day..item.end_of_day).count }
		@graph = LazyHighCharts::HighChart.new('graph') do |f|
           f.title(text: '投稿 月間登録推移')
           f.xAxis(categories: days)
           f.series(name: '登録数', data: diaries)
           end
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

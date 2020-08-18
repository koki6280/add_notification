class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries
		days = (Date.today.beginning_of_month..Date.today).to_a
        cigarettes = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.cigarette&.to_i}
        @graph = LazyHighCharts::HighChart.new('graph') do |f|
        	f.title(text: '喫煙本数')
        	f.xAxis(categories: days)
        	f.series(name: '本数', data: cigarettes)
        end
        days = (Date.today.beginning_of_month..Date.today).to_a
        sleeps = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.sleep&.to_i}
        @graph1 = LazyHighCharts::HighChart.new('graph') do |f|
        	f.title(text: '喫煙本数')
        	f.xAxis(categories: days)
        	f.series(name: '本数', data: sleeps)
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

class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries.page(params[:page]).reverse_order
		@model = params["model"]


		days = (Date.today.beginning_of_month..Date.today).to_a
		days2 = (Date.today.beginning_of_week..Date.today).to_a
        exercises = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.exercise&.to_i}
        exercises_w = days2.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.exercise&.to_i}

        @graph = LazyHighCharts::HighChart.new('graph') do |f|
        	   f.title(text: '運動時間')
        	   f.xAxis(categories: days)
        	   f.series(name: '時間', data: exercises)
        	   f.chart(type: "column")
        end

        sleeps = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.sleep&.to_i}
        @graph2 = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '睡眠時間')
		     f.xAxis(categories: days)
		     f.series(name: '時間', data: sleeps)
		     f.chart(type: "column")
		end

		cigarettes = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.cigarette&.to_i}
        @graph3 = LazyHighCharts::HighChart.new('graph') do |f|
        	f.title(text: '喫煙本数')
        	f.xAxis(categories: days)
        	f.series(name: '本', data: cigarettes)
        	f.chart(type: "column")
        end

        drinkings = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.drinking&.to_i}
        @graph4 = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '飲酒量')
		     f.xAxis(categories: days)
		     f.series(name: '缶', data: drinkings)
		     f.chart(type: "column")
		end
	end

	def index
		@users = User.all
	end

	def favorites
		@user = User.find(params[:id])
		@diaries = @user.favorite_diaries.page(params[:page]).reverse_order
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

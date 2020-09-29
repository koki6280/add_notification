class UsersController < ApplicationController
	before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
	
	def show
		@user = User.find(params[:id])
		@diaries = @user.diaries.page(params[:page]).reverse_order

		@current_entry = Entry.where(user_id: current_user.id)
		@another_entry = Entry.where(user_id: @user.id)
		unless @user.id == current_user.id
			@current_entry.each do |current|
				@another_entry.each do |another|
					if current.room_id == another.room_id
						@is_room = true
                        @room_id = current.room_id
					end
				end
			end
			unless @is_room
				@room = Room.new
                @entry = Entry.new
			end
		end


		days = (Date.today.beginning_of_week..Date.today).to_a
        exercises = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.exercise&.to_i}

        @graph = LazyHighCharts::HighChart.new('graph') do |f|
        	   f.title(text: '運動時間(週)')
        	   f.xAxis(categories: days)
        	   f.series(name: '時間', data: exercises)
        	   f.chart(type: "column")
        end

        sleeps = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.sleep&.to_i}
        @graph2 = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '睡眠時間(週)')
		     f.xAxis(categories: days)
		     f.series(name: '時間', data: sleeps)
		     f.chart(type: "column")
		end

		cigarettes = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.cigarette&.to_i}
        @graph3 = LazyHighCharts::HighChart.new('graph') do |f|
        	f.title(text: '喫煙本数(週)')
        	f.xAxis(categories: days)
        	f.series(name: '本', data: cigarettes)
        	f.chart(type: "column")
        end

        drinkings = days.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.drinking&.to_i}
        @graph4 = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '飲酒量(週)')
		     f.xAxis(categories: days)
		     f.series(name: '缶', data: drinkings)
		     f.chart(type: "column")
		end
	end

	def graphs
		@user = User.find(params[:id])

		days2 = (Date.today.beginning_of_month..Date.today).to_a
		days3 = (Date.today.beginning_of_year..Date.today).to_a

		exercises_m = days2.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.exercise&.to_i}
		exercises_y = days3.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.exercise&.to_i}
        @graph_m = LazyHighCharts::HighChart.new('graph') do |f|
        	   f.title(text: '運動時間(月)')
        	   f.xAxis(categories: days2)
        	   f.series(name: '時間', data: exercises_m)
        	   f.chart(type: "column")
        end
        @graph_y = LazyHighCharts::HighChart.new('graph') do |f|
        	   f.title(text: '運動時間(年)')
        	   f.xAxis(categories: days3)
        	   f.series(name: '時間', data: exercises_y)
        	   f.chart(type: "column")
        end

        
        sleeps_m = days2.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.sleep&.to_i}
        sleeps_y = days3.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.sleep&.to_i}
        @graph2_m = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '睡眠時間(月)')
		     f.xAxis(categories: days2)
		     f.series(name: '時間', data: sleeps_m)
		     f.chart(type: "column")
		end
		@graph2_y = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '睡眠時間(年)')
		     f.xAxis(categories: days3)
		     f.series(name: '時間', data: sleeps_y)
		     f.chart(type: "column")
		end

		
		cigarettes_m = days2.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.cigarette&.to_i}
		cigarettes_y = days3.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.cigarette&.to_i}
        @graph3_m = LazyHighCharts::HighChart.new('graph') do |f|
        	f.title(text: '喫煙本数(月)')
        	f.xAxis(categories: days2)
        	f.series(name: '本', data: cigarettes_m)
        	f.chart(type: "column")
        end
        @graph3_y = LazyHighCharts::HighChart.new('graph') do |f|
        	f.title(text: '喫煙本数(年)')
        	f.xAxis(categories: days3)
        	f.series(name: '本', data: cigarettes_y)
        	f.chart(type: "column")
        end


        drinkings_m = days2.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.drinking&.to_i}
        drinkings_y = days3.map {|day| @user.diaries.find{|x| x.created_at.to_date == day}&.drinking&.to_i}
        @graph4_m = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '飲酒量(月)')
		     f.xAxis(categories: days2)
		     f.series(name: '缶', data: drinkings_m)
		     f.chart(type: "column")
		end
		@graph4_y = LazyHighCharts::HighChart.new('graph') do |f|
		     f.title(text: '飲酒量(年)')
		     f.xAxis(categories: days3)
		     f.series(name: '缶', data: drinkings_y)
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

		if @user.update(user_params)
		   redirect_to user_path(current_user)
		else
			render 'edit'
		end
	end

	def follows
	end

	def followers
	end

	private

	def user_params
        params.require(:user).permit(:nickname, :profile, :profile_image)
    end

    def ensure_correct_user
        @user = User.find(params[:id])
	    unless @user == current_user
	      redirect_to user_path(current_user)
	    end
    end
end

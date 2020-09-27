class CommentsController < ApplicationController

	def create
		@diary = Diary.find(params[:diary_id])
        @comment = @diary.comments.new(comment_params)
        @comment.user_id = current_user.id
        @comment_diary = @comment.diary
      if  @comment.save
        @comment_diary.create_notification_comment!(current_user, @comment.id)
        redirect_to request.referer
      end

	end

	def destroy
	       @comment = Comment.find(params[:diary_id])
	       @diary = @comment.diary
	    if @comment.user == current_user
	       @comment.destroy
	    end
	       redirect_to request.referer
	end

	def comment_params
        params.require(:comment).permit(:comment)
    end

end

class CommentsController < ApplicationController

	def create
		@diary = Diary.find(params[:diary_id])
        @comment = @diary.comments.new(comment_params)
        @comment.user_id = current_user.id
      if  @comment.save
        flash[:success] = "Comment was successfully created."
        redirect_to request.referer
      end

	end

	def destroy
		   @diary = Diary.find(params[:diary_id])
	       @comment = Comment.find(params[:id])
	    if @comment.user == current_user
	       @comment.destroy
	    end
	       redirect_to request.referer
	end

	def comment_params
        params.require(:comment).permit(:comment)
    end

end

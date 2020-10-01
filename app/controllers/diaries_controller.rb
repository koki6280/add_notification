class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    @diary.score = Language.get_data(diary_params[:body])
    if @diary.save
      redirect_to user_path(current_user)

    else
      render 'new'
    end
  end

  def index
    @diaries = Diary.page(params[:page]).reverse_order
    if params[:tag_name]
      @diaries = Diary.tagged_with("#{params[:tag_name]}").page(params[:page]).reverse_order
        end
  end

  def show
    @diary = Diary.find(params[:id])
    @comment = Comment.new
    @comments = @diary.comments
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])

    if @diary.update(diary_params)
      redirect_to user_path(current_user)

    else
      render 'edit'
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to user_path(current_user)
  end

  private

  def diary_params
    params.require(:diary).permit(:body, :body_image, :exercise, :sleep, :cigarette, :drinking, :tag_list)
  end

  def ensure_correct_user
    @diary = Diary.find(params[:id])
    unless @diary.user == current_user
      redirect_to diaries_path
      end
    end
end

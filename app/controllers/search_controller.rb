class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @datas = search_for(@model, @content).page(params[:page]).reverse_order
  end

  private

  def search_for(model, content)
    if model == 'user'
      User.where('nickname LIKE ?', '%' + content + '%')
    else model == 'diary'
         Diary.where('body LIKE ?', '%' + content + '%')
      end
  end
end

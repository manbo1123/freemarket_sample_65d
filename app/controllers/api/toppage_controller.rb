class Api::ToppageController < ApplicationController
  def index
    # ajaxで送られてくる最後のメッセージのid番号を変数に代入
    # category_id = params[:id]
    @children = Category.find(params[:id]).children
  end
end

class CommentsController < ApplicationController
  before_action :set_item
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to item_path(@item)
    else
      flash[:danger] = "コメントできませんでした"
      redirect_to item_path(@item)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "削除しました"
      redirect_to item_path(@item)
    else
      flash[:danger] = "削除できませんでした"
      redirect_to item_path(@item)
    end
  end

  private
  def comment_params
    params.required(:comment).permit(:comment).merge(user_id: current_user.id,item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
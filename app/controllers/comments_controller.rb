class CommentsController < ApplicationController
  before_action :set_instance
  def create
    Comment.create(comment_params)
    redirect_to item_path(@item)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to item_path(@item)
  end

  private
  def comment_params
    params.required(:comment).permit(:comment).merge(user_id: current_user.id,item_id: params[:item_id])
  end

  def set_instance
    @item = Item.find(params[:item_id])
  end
end
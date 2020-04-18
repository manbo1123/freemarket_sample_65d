class Api::ItemsController < ApplicationController
  def index
    @children = Category.find(params[:id]).children
  end
end

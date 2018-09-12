class CategoriesController < ApplicationController
  def index
  end

  def show
    @posts = Category.find(params[:id]).posts
  end

  def new

  end

  def edit

  end

  def create
  end

end
class CategoriesController < ApplicationController
  def index

  end

  def show

  end

  def new

  end

  def edit

  end

  def create
    @category = Category.create(post_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successful created.' }
      end  
    end
  end

  private

    def post_params
      params.require(:category).permit(:name)
    end

end
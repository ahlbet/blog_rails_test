require "rails_helper"

describe CategoriesController do

  let(:valid_attributes) {
    { name: 'Science' }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      category = Category.create!(name: 'My Test')
      get :show, params: { id: category.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      category = Category.create!(name: 'My Test')
      get :edit, params: { id: category.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {category: valid_attributes}
        }.to change(Category, :count).by(1)
      end

      # it "redirects to the created category" do
      #   post :create, params: { category: { name: 'My Test' } }
      #   expect(response).to redirect_to(Category.last)
      # end
    end
  end

end
require 'rails_helper'
require 'support/controller_macros'

RSpec.describe PostsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Test User', title: 'Test Title', content: 'Test Content', categories_attributes: [{ name: 'Tech' }, { name: 'Health' }]}
  }

  let(:user) {
    User.create({ email: "dylan@20spokes.com", password: "password" })
  }

  let(:invalid_attributes) {
    { name: nil, title: nil, content: nil, categories_attributes: [{ name: nil }] }
  }

  let(:valid_session) { { email: 'testing@testing.com', password: 'password' } }


  describe "GET #index" do
    context "logged in" do
      # login_user({ email: 'testing@testing.com', password: 'password' })

      xit "returns a success response" do
        post = Post.new(valid_attributes)
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        post.user = user
        post.save!
  
        get :index
        expect(response).to be_successful
      end
    end

    context "no user is signed in" do
      xit "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    # login_user({ email: 'testing@testing.com', password: 'password' })
    xit "returns a success response" do
      post = Post.new(valid_attributes)
      user = User.create!(email: "dylan@20spokes.com", password: "password")
      post.user = user
      post.save!
      sign_in user
      get :show, params: {id: post.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    # login_user({ email: 'testing@testing.com', password: 'password' })
    xit "returns a success response" do
      user = User.create!(email: "dylan@20spokes.com", password: "password")
      sign_in user
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end

  end

  describe "GET #edit" do
    xit "returns a success response" do
      post = Post.new(valid_attributes)
      user = User.create!(email: "dylan@20spokes.com", password: "password")
      post.user = user
      post.save!
      sign_in user
      get :edit, params: {id: post.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  # TODO: Write test for strong params/creating post with categories

  describe "POST #create" do
    context "with valid params" do
      # login_user({ email: 'testing@testing.com', password: 'password' })
      it "creates a new Post" do
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        sign_in user
        expect {
          post :create, params: {post: valid_attributes}
        }.to change(Post, :count).by(1)
      end
      
      xit "creates a new Post with Categories" do
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        sign_in user
        expect {
          post :create, params: {post: valid_attributes}
        }.to change(Category, :count).by(2)
      end

      xit "redirects to the created post" do
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        sign_in user
        post :create, params: {post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Post.last)
      end

    end

    context "with invalid params" do
      xit "returns a success response (i.e. to display the 'new' template)" do
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        sign_in user
        post :create, params: {post: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'New Name', title: 'New Title', content: 'New Content' }
      }

      xit "updates the requested post" do
        post = Post.new(valid_attributes)
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        post.user = user
        post.save!
        sign_in user
        put :update, params: {id: post.to_param, post: new_attributes}, session: valid_session
        post.reload
        new_attributes.each_pair do |key, value|
          expect(post[key]).to eq(value)
        end
      end

      xit "redirects to the post" do
        post = Post.new(valid_attributes)
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        post.user = user
        post.save!
        sign_in user
        put :update, params: {id: post.to_param, post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid params" do
      xit "returns a success response (i.e. to display the 'edit' template)" do
        post = Post.new(valid_attributes)
        user = User.create!(email: "dylan@20spokes.com", password: "password")
        post.user = user
        post.save!
        sign_in user
        put :update, params: {id: post.to_param, post: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    # login_user({ email: 'testing@testing.com', password: 'password' })
    xit "destroys the requested post" do
      post = Post.new(valid_attributes)
      user = User.create!(email: "dylan@20spokes.com", password: "password")
      post.user = user
      post.save!
      sign_in user
      expect {
        delete :destroy, params: {id: post.to_param}, session: valid_session
      }.to change(Post, :count).by(-1)
    end

    xit "redirects to the posts list" do
      post = Post.new(valid_attributes)
      user = User.create!(email: "dylan@20spokes.com", password: "password")
      post.user = user
      post.save!
      sign_in user
      delete :destroy, params: {id: post.to_param}, session: valid_session
      expect(response).to redirect_to(posts_url)
    end
  end

  describe "AUTH" do
    xit "logs the user in" do
      user = User.create!(email: 'test@test.com', password: 'password')
      sign_in user
      expect(controller.current_user).to eq(user)

      sign_out user
      expect(controller.current_user).to be_nil
    end
  end

end

require 'rails_helper'
require 'support/controller_macros'

RSpec.describe PostPolicy do
  # subject { PostPolicy.new(user, post) }

  let(:valid_attributes) {
    { name: 'Test User', title: 'Test Title', content: 'Test Content' }
  }

  describe 'scope' do
    it 'returns posts for the passed in user' do
      user = User.create!(email: "harrison@20spokes.com", password: "password")

      post = Post.create!(user: user, name: "Test Post", title: "Test Title", content: "Test Content")

      result = PostPolicy::Scope.new(user, Post).resolve

      expect(result).to include(post)
    end

    it 'should not return posts for unrelated users' do
      user1 = User.create!(email: "harrison@20spokes.com", password: "password")
      user2 = User.create!(email: "dylan@20spokes.com", password: "password")

      post = Post.create!(user: user1, name: "Test Post", title: "Test Title", content: "Test Content")

      result = PostPolicy::Scope.new(user2, Post).resolve

      expect(result).to_not include(post)

    end

    context 'when user is not provided' do
      it 'should return all posts' do
        user = User.create!(email: "harrison@20spokes.com", password: "password")

        post = Post.create!(user: user, name: "Test Post", title: "Test Title", content: "Test Content")

        result = PostPolicy::Scope.new(nil, Post).resolve

        expect(result).to include(post)
      end
    end
  end

  # user1 = login_user({email: 'test@test.com', password: 'password'})
  # user2 = login_user(email: 'test1@test1.com', password: 'password')

  describe 'separation of user posts' do
    it 'should not be able to see other user posts' do

      # user1 = User.create!(email: 'test4@test.com', password: 'password')
      # sign_in user1
      # data = { name: 'Test User', title: 'Test Title', content: 'Test Content', user_id: user1.id }
      # newPost = Post.create! data
      # p newPost
      # sign_out user1

      # user2 = User.create!(email: 'test5@test1.com', password: 'password')
      # sign_in user2
      # get :index
      # expect(response).to be_nil
    end
  end
end
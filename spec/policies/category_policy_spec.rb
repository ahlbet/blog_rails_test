require 'rails_helper'
require 'support/controller_macros'

RSpec.describe CategoryPolicy do

  describe 'scope' do

    it 'returns posts for passed in user and category' do
      user = User.create!(email: "dylan@20spokes.com", password: "password")
      post1 = Post.create!(user: user, name: "test1", title: 'title1', content: 'content1', categories_attributes: [{ name: 'Tech1' }])
      post2 = Post.create!(user: user, name: "test2", title: 'title2', content: 'content2', categories_attributes: [{ name: 'Tech2' }])

      result = PostPolicy::Scope.new(user, Post).resolve

      expect(result).to include(post1)

    end

  end

end
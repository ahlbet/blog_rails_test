require 'rails_helper'
require 'support/controller_macros'

RSpec.describe "posts/index", type: :view do
  let(:valid_attributes) {
    { name: 'Name', title: 'Title', content: 'MyText', categories_attributes: [{ name: 'Tech' }]}
  }

  it "renders a list of posts" do
    @user = User.create!(email: "dylan@20spokes.com", password: "password")
    assign(:posts, [
      Post.create!(
        :name => "Name",
        :title => "Title",
        :content => "Content",
        :user_id => @user.id
      ),
      Post.create!(
        :name => "Name",
        :title => "Title",
        :content => "Content",
        :user_id => @user.id
      )
    ])

    render
    assert_select "tr>td", :text => "Name", :count => 2
    assert_select "tr>td", :text => "Title", :count => 2
    assert_select "tr>td", :text => "Content", :count => 2
  end

end

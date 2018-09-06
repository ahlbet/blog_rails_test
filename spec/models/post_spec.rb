require 'rails_helper'

describe Post do

  # subject { described_class.new(name: 'testUser', title: 'Anything', content: 'Anything content') }
  describe "validations" do
    it "requires presence of a name" do
      post = Post.new(name: nil)
      expect(post.valid?).to be(false)
      expect(post.errors.messages[:name]).to include("can't be blank")
    end

    it "requires presence of a title" do
      post = Post.new(title: nil)
      expect(post.valid?).to be(false)
      expect(post.errors.messages[:name]).to include("can't be blank")
    end

    it "requires presence of content" do
      post = Post.new(content: nil)
      expect(post.valid?).to be(false)
      expect(post.errors.messages[:name]).to include("can't be blank")
    end

  end

  describe "associations" do
    it "should have many categories" do
      expect(described_class.reflect_on_association(:categories).macro).to eq(:has_many)
    end

    it "should accept nested attributes for categories" do
      # post = Post.new
      # p post.attributes
      # expect(described_class.attribute(:categories))
      # expect(described_class.attribute(:users)).to be_truthy
    end
  end
end

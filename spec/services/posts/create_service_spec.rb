require "rails_helper"

RSpec.describe Posts::CreateService do

  let(:valid_attributes) {
    { name: 'Test User', title: 'Test Title', content: 'Test Content', categories_attributes: [{ name: 'Tech' }, { name: 'Health' }], user_id: user.id}
  }

  let(:invalid_attributes) {
    { name: nil, title: nil, content: nil, categories_attributes: [nil, nil], user_id: nil }
  }

  let(:invalid_post) do
    Post.create(name: nil, title: nil, content: nil, user: nil)
  end

  let(:post) do
    Post.create(name: "Test Post", title: "Test Title", content: "Test Content", user: user)
  end

  let(:user) {
    User.create({ email: "dylan@20spokes.com", password: "password" })
  }

  let(:service) do
    described_class.new(valid_attributes)
  end

  describe "#hash_into_array" do
    it "extracts specific value from a given key" do
      service = described_class.new(valid_attributes)
      test_hash = { "0" => { "name" => "Health" }, "1" => { "name" => "Tech" } }
      expect(service.hash_into_array(test_hash, "name")).to eq(["Health", "Tech"])
    end
  end

  describe "#confirm_or_create" do
    it "creates the correct amount of categories when no categories are found matching the given names" do
      category_names = ["Health", "Tech"]
      expect { service.confirm_or_create(category_names, post) }.to change { Category.count }.by(category_names.length)
    end

    it "does not create a new category when a category  already exists for a given name" do
      category_names = ["Health", "Tech"]
      Category.create!(name: category_names.first)

      expect { service.confirm_or_create(category_names, post) }.to change { Category.count }.by(1)
    end

    it "should associate the given post to the categories" do
      category_names = ["Health", "Tech"]
      expect { service.confirm_or_create(category_names, post) }.to change { post.reload.categories.count }.by(2)
    end
  end

  describe "#errors" do
    it "should initialize to an empty array" do
      expect(service.errors).to eq([])
    end

    it "should not create a new post given invalid attributes" do
      service = described_class.new(invalid_attributes)
      expect { service.send(:create_post).to change { Post.count }.by(0) }
    end

    it "should populate the errors array when attempting to create invalid post" do
      service = described_class.new(invalid_attributes)
      service.send(:create_post)
      expect(service.errors).not_to be_empty
    end

    it "should respond with can't be blank error messages" do
      service = described_class.new(invalid_attributes)
      service.send(:create_post)
      error_messages = ["Name can't be blank", "Title can't be blank", "Content can't be blank", "User must exist"]
      expect(service.errors.full_messages).to eq(error_messages)
    end

    it "should populate the errors array when attempting to create invalid categories" do
      category_names = [nil, nil]
      service.confirm_or_create(category_names, post)
      expect(service.errors).not_to be_empty
    end

    it "should respond with can't be blank error messages" do
      category_names = [nil, nil]
      service.confirm_or_create(category_names, post)
      error_messages = ["Name can't be blank"]
      expect(service.errors.full_messages).to eq(error_messages)
    end

  end


  xit "creates a new Post by calling create_post in call" do
    service = described_class.new(valid_attributes)
    expect {
      service.call
    }.to change {Post.count}.by(1)
  end

  xit "creates a new Post within the private create_post method" do
    service = described_class.new(valid_attributes)
    expect(service.send(:create_post)).to be true
  end

  xit "receives a list of categories from params" do
    service = described_class.new(valid_attributes)
    expect(service.params).to include(:categories_attributes)
  end

  xit "extracts the list of categories from params into an array" do
    service = described_class.new(valid_attributes)
    expect(service.hash_into_array(valid_attributes[:categories_attributes], :name)).to eq(["Tech", "Health"])
  end

  xit "creates association in posts_categories for all passed in categories" do
    service = described_class.new(valid_attributes)
    category_array = service.hash_into_array(valid_attributes[:categories_attributes], :name)
    user = User.create!({ email: "harrison@20spokes.com", password: "password" })
    post = Post.create!({ name: "Wow", title: "Wow", content: "Wow", user_id: user.id })
    expect {
      service.confirm_or_create(category_array, post)
    }.to change { PostsCategory.count }.by(2)
  end

    

end
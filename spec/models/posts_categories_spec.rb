require "rails_helper"

describe PostsCategory do
  describe "associations" do
    it "belongs to one post" do
      expect(described_class.reflect_on_association(:post).macro).to eq(:belongs_to)
    end

    it "belongs to one category" do
      expect(described_class.reflect_on_association(:category).macro).to eq(:belongs_to)
    end
  end
end
require "rails_helper"

describe Category do
  describe "validations" do
    it "requires the presence of name" do
      category = Category.new(name: nil)

      expect(category.valid?).to be(false)
      expect(category.errors.messages[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "should have many posts" do
      expect(described_class.reflect_on_association(:posts)).to eq(:has_many)
    end
  end
end
require 'rails_helper'

describe User do
  describe "associations" do
    it "should have many posts" do
      expect(described_class.reflect_on_association(:posts).macro).to eq(:has_many)
    end
  end
end

class CreatePostsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :posts_categories do |t|
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end

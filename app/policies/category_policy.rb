class CategoryPolicy < ApplicationPolicy
  class Scope
    attr_reader :post_id, :scope

    def initialize(post_id, scope)
      @post_id = post_id
      @scope = scope
    end

    def resolve
      # p scope.joins("INNER JOIN posts_categories ON posts_categories.category_id = scope.id INNER JOIN posts ON posts_categories.post_id = posts.id")
      # p Category.joins(:posts_categories, :posts)
      # scope.where(post_id: @post_id)
      # scope.all    
      # scope.joins(:posts_categories, :posts)
    end

  end
end
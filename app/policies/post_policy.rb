class PostPolicy < ApplicationPolicy

  def show?
    return true if user.present? && user == post.user
  end

  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == post.user
  end

  def destroy?  
    return true if user.present? && user == post.user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present?
        scope.where(user: user)
      else 
        scope.all
      end    
    end
  end

  private

    def post
      record
    end

end

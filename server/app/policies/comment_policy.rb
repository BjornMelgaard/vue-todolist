class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.comments
    end
  end
end

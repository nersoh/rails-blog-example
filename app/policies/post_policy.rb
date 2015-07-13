class PostPolicy < ApplicationPolicy

	def index?
		true
	end

	def show?
		index?
	end

	def new?
		user
	end

	def create?
		new?
	end

	def edit?
		new?
	end

	def update?
		edit?
	end

	def destroy?
		create?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

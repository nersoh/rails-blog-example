class PagesController < ApplicationController

	def home
		@posts = Post.where(published: true)
	end

	def search
		
	end
end

class PostsController < ApplicationController

	def index
		@posts = Post.where(published: true)
		authorize @posts
	end

	def show
		@post = Post.find(params[:id])
	end
	
end

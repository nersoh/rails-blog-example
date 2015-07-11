class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :delete]

	def index
		@posts = Post.where(published: true)
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
	end

	def edit
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to @post
		else
			render :new
		end
	end

	def update
		if @post.update_attributes(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :published)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end

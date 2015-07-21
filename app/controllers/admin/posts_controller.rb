class Admin::PostsController < ApplicationController
	after_action :verify_authorized, except: [:index, :show]
	before_action :authenticate_admin!, except: [:index, :show]
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
		authorize @posts
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
		authorize @post
	end

	def edit
	end

	def create
		@post = current_admin.posts.build(post_params)
		authorize @post
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

	def destroy
		@post.destroy
		redirect_to posts_url
	end

	def publish
		@posts = Post.where(id: params[:post_ids])
		authorize @posts
		@posts.update_all(published: true)
		redirect_to admin_drafts_url
	end

	def unpublish
		@posts = Post.where(id: params[:post_ids])
		authorize @posts
		@posts.update_all(published: false)
		redirect_to admin_drafts_url
	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :published)
	end

	def set_post
		@post = Post.find(params[:id])
		authorize @post
	end
end

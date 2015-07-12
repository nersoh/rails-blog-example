require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	describe "get INDEX" do
		it "assigns @posts" do
			post = FactoryGirl.create(:post)
		  get :index
		  expect(assigns(:posts)).to eq([post])
		end

		it "rendes Index template" do
			get :index
			expect(response).to render_template(:index)
		end

		it "does not assigns unpublished posts" do
			post = FactoryGirl.create(:post, published: false)
			get :index
			expect(assigns(:posts)).not_to include(post)
		end
	end

	describe "GET show" do
	  it "assigns @post" do
	  	post = FactoryGirl.create(:post)
	  	get :show, id: post
	  	expect(assigns(:post)).to eq(post)
	  end
	end

	describe "POST create" do
	  context "valid attributes" do
	  	it "get new post page" do
	  		get :new
	  		expect(response).to render_template(:new)
	  	end
	  	it "creates a new post" do
	  		expect {
	  			post :create, post: FactoryGirl.attributes_for(:post)
	  		}.to change(Post, :count).by(1)
	  	end

	  	it "redirects to post page" do
				post :create, post: FactoryGirl.attributes_for(:post)
	  		expect(response).to redirect_to(Post.last)
	  	end
	  end

	  context "invalid attributes" do
	  	it "shows post errors" do
	  		post :create, post: FactoryGirl.attributes_for(:post, title: nil, content: nil)
	  		expect(assigns(:post).errors.full_messages).not_to eq([])
	  	end
	  end
	end

	describe "PUT update" do
		before :each do
			@post = FactoryGirl.create(:post)
		end
		context "valid information" do
		  it "changes post's title" do
		  	title = "title2"
		  	put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: title)
		  	@post.reload
		  	expect(@post.title).to eq(title)
		  end

		  it "updates a post" do
		  	put :update, id: @post, post: FactoryGirl.attributes_for(:post, 
		  			title: "t1", content: "content", published: true)
		  	expect(response).to redirect_to(@post)
		  end
		end

		context "invalid information" do
			it "goes back to edit page" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:post,
					title: nil)
				expect(response).to render_template(:edit)
			end
		end
	end
	describe "DELETE post" do
		it "destroys a post" do
			post = FactoryGirl.create(:post)
			expect {
				delete :destroy, id: post
			}.to change(Post, :count).by(-1)
		end
	end
end

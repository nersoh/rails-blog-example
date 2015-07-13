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
	  context "admin not logged in" do

	  	it "redirects to login page" do
	  		get :new
	  		expect(response.body).to redirect_to("/login")
	  	end
	  	it "cannot create a new post" do
	  		expect {
	  			post :create, post: FactoryGirl.attributes_for(:post)
	  		}.not_to change(Post, :count)
	  	end
	  end

	  context "admin logged in" do
	  	before :each do
		  	admin = FactoryGirl.create(:admin)
		  	sign_in admin
	  	end

	  	it "redirects to login page" do
	  		get :new
	  		expect(response).to render_template(:new)
	  	end

	  	it "creates a new post" do
	  		expect { 
	  			post :create, post: FactoryGirl.attributes_for(:post)
	  		 }.to change(Post, :count).by(1)
	  	end

	  	it "does not create a new post with invalid attributes" do
	  		expect { 
	  			post :create, post: FactoryGirl.attributes_for(:post, title: nil, content: nil)
	  		 }.not_to change(Post, :count)
	  	end
	  end
	end

	describe "PUT update" do
		before :each do
			@post = FactoryGirl.create(:post)
		end
		context "admin not logged in" do
		  it "cannot change posts" do
		  	title = "title2"
		  	put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: title)
		  	@post.reload
		  	expect(@post.title).not_to eq(title)
		  end

		  it "goes to login page when trying to update" do
		  	put :update, id: @post, post: FactoryGirl.attributes_for(:post, 
		  			title: "t1", content: "content", published: true)
		  	expect(response).to redirect_to(new_admin_session_path)
		  end
		end

		context "admin logged in" do
			before :each do
		  	admin = FactoryGirl.create(:admin)
		  	sign_in admin
	  	end
			
			it "renders edit page" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:post,
					title: nil)
				expect(response).to render_template(:edit)
			end

			it "changes post title" do
				title = "new title"
				put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: title)
				@post.reload
				expect(@post.title).to eq(title)
			end
		end
	end
	describe "DELETE post" do
		before :each do
			@post = FactoryGirl.create(:post)
		end

		context "admin logged in" do
			before :each do
				admin = FactoryGirl.create(:admin)
				sign_in admin
			end
			it "destroys a post" do
				expect { delete :destroy, id: @post }.to change(Post, :count).by(-1)
			end
		end

		context "admin not logged in" do
			it "is not able to delete posts" do
				expect { delete :destroy, id: @post }.not_to change(Post, :count)
			end	
		end
	end
end

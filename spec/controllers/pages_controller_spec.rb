require 'rails_helper'

RSpec.describe PagesController, type: :controller do
	describe "GET home" do
		it "renders home template" do
			get :home
			expect(response).to render_template(:home)
		end
	  it "assigns @posts" do
	  	post = FactoryGirl.create(:post)
	  	get :home
	  	expect(assigns(:posts)).to include(post)
	  end
	  it "does show unpublished posts" do
	  	post = FactoryGirl.create(:post, published: false)
	  	get :home
	  	expect(assigns(:posts)).not_to include(post)
	  end
	end
end

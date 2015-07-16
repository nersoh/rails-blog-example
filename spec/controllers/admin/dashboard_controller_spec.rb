require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do

  describe "GET #index" do
  	context "admin logged in" do
  		before :each do
  			admin = FactoryGirl.create(:admin)
  			sign_in admin
  		end
	    it "returns http success" do
	      get :index
	      expect(response).to have_http_status(:success)
	    end
  	end

  	context "no admin logged in" do
  		it "redirects to login page" do
  			get :index
  			expect(response).to redirect_to "/login"
  		end
  	end
  end

  describe "GET drafts" do
    before :each do
      admin = FactoryGirl.create(:admin)
      sign_in admin
    end
    it "access drafts page" do
      post = FactoryGirl.create(:post, published: false)
      get :drafts
      expect(response).to have_http_status(:success)
      expect(assigns(:posts)).to include(post)
    end
  end

end

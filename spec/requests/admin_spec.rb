require 'rails_helper'

RSpec.describe "Admin::Dashboard", type: :request do
	describe "GET index" do
		context "Admin logged in" do
		  it "shows admin navbar" do
		  	login_as_admin
		  	get admin_dashboard_path
		  	expect(response.body).to match /navbar-admin/
		  end
		end
		context "Admin is not logged in" do
			it "does not show admin navbar" do
				get admin_dashboard_path
				expect(response.body).not_to match /navbar-admin/
			end
		end
	end
end
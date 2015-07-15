require 'rails_helper'

RSpec.feature "Admin", type: :feature do
	let(:admin) { FactoryGirl.create(:admin) }
	scenario "should accesses dashboard" do
	  log_in admin
	  expect(page).to have_content("Dashboard")
	  expect(page).to have_css(".navbar-admin")
	end
end
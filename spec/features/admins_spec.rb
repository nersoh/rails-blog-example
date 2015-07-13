require 'rails_helper'

RSpec.feature "Admin", type: :feature do
	let(:admin) { FactoryGirl.create(:admin) }
  scenario 'should be able to log in' do
    visit "/login"
    within("#new_admin") do
    	fill_in "admin_email", with: admin.email
      fill_in "admin_password", with: admin.password
      click_button "Log in"
    end
    expect(page).to have_content("Log out")
  end
  scenario "should be able to log out" do
  	log_in admin
  	click_link "Log out"
  	expect(page).to have_text "Log in"
  end
end

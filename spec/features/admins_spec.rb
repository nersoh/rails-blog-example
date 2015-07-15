require 'rails_helper'

RSpec.feature "Admin", type: :feature do
	let(:admin) { FactoryGirl.create(:admin) }
  scenario 'should be able to log in' do
    log_in admin
    expect(page).to have_content("Log out")
  end
  scenario "should be able to log out" do
  	log_in admin
  	click_link "Log out"
  	expect(page).to have_text "Log in"
  end

  scenario "Creates a new post" do
    log_in admin
    visit "posts/new"
    post_title = Faker::Lorem.sentence
    post_content = Faker::Lorem.paragraph
    fill_in "post_title", with: post_title
    fill_in "post_content", with: post_content
    click_button "Create post"
    expect(page).to have_content post_title
  end
end

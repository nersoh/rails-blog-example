require 'rails_helper'

RSpec.feature "Admin", type: :feature do
	let(:admin) { FactoryGirl.create(:admin) }
  scenario 'should be able to log in' do
    log_in admin
    expect(page).to have_content("Log out")
    expect(page).to have_css("li", text: "Dashboard")
  end
  scenario "should be able to log out" do
  	log_in admin
  	click_link "Log out"
  	expect(page).not_to have_text "Log out"
    expect(page).not_to have_css(".navbar-admin")
  end

  scenario "Creates a new post" do
    log_in admin
    visit "/admin/posts/new"
    post_title = Faker::Lorem.sentence
    post_content = Faker::Lorem.paragraph
    create_post(post_title, post_content, true)
    expect(page).to have_content post_title
  end

  scenario "publishes all draft posts" do
    log_in admin
    # Creates some records
    3.times do
      visit "/admin/posts/new"
      create_post(
        Faker::Lorem.sentence,
        Faker::Lorem.paragraph,
        false
      )
    end
    visit admin_drafts_url
    all("input[type=checkbox]").each do |checkbox|
      checkbox.set(true)
    end
    click_button("Publish All Selected")
    expect(page).to have_text("No records found")
  end
end

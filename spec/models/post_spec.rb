require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
  	@post = FactoryGirl.build(:post)
  end

  it "is a valid post" do
  	expect(@post).to be_valid
  end

  it "needs a title" do
  	@post.title = nil
  	expect(@post).not_to be_valid
  end

  it "needs a content" do
  	@post.content = nil
  	expect(@post).not_to be_valid
  end
end

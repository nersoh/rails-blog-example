require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    admin = FactoryGirl.build(:admin)
  	@post = FactoryGirl.build(:post, admin: admin)
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

  it "belongs to admin" do
    expect(@post.admin).not_to be_nil
  end

  it "is not valid without admin" do
    @post.admin = nil
    expect(@post).not_to be_valid
  end
end

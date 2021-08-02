require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment = comments(:one)
    @user = users(:john)
    @restaurant = restaurants(:tierra_del_fuego)
  end

  test "can create a comment with valid attributes" do
    new_comment = Comment.new(user: @user, restaurant: @restaurant, description: "This is by far the best Mexican restaurant in Houston", rating: 5)
    new_comment.valid?
    assert new_comment.errors.empty?
  end

  test "can create a comment with valid description" do
    new_comment = Comment.new(description: "This is by far the best Mexican restaurant in Houston")
    new_comment.valid?
    assert new_comment.errors[:description].empty?
  end

  test "cannot create comment without description" do
    new_comment = Comment.new(user: @user, restaurant: @restaurant, rating: 5)
    new_comment.valid?
    assert_not new_comment.errors[:description].empty?
  end

  test "cannot create comment with description of less than 20 characters" do
    new_comment = Comment.new(user: @user, restaurant: @restaurant, rating: 5, description: "hello")
    new_comment.valid?
    assert_not new_comment.errors[:description].empty?
  end

  test "can create a comment with valid rating" do
    1.upto(5) do |i|
      new_comment = Comment.new(rating: i)
      new_comment.valid?
      assert new_comment.errors[:rating].empty?
    end
  end

  test "cannot create a comment without rating" do
    new_comment = Comment.new
    new_comment.valid?
    assert_not new_comment.errors[:rating].empty?
  end

  test "cannot create a comment with negative rating" do
    new_comment = Comment.new(rating: -5)
    new_comment.valid?
    assert_not new_comment.errors[:rating].empty?
  end

  test "cannot create a comment with decimals in rating" do
    new_comment = Comment.new(rating: 0.5)
    new_comment.valid?
    assert_not new_comment.errors[:rating].empty?
  end
end

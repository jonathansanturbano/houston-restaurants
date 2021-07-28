require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  CATEGORIES = ["Thai", "Mexican", "American", "Vietnamese"]

  setup do
    @restaurant = restaurants(:tierra_del_fuego)
  end

  test "can create a restaurant" do
    restaurant = Restaurant.new(name: "Bananas Thai", description: "Thai restaurant is the greatest place to bring your family", category: CATEGORIES[0], user: users(:john))
    restaurant.valid?
    assert restaurant.errors.empty?
  end

  test "can create restaurant with valid name attribute" do
    restaurant = Restaurant.new(name: "Bananas Thai")
    restaurant.valid?
    assert restaurant.errors[:name].empty?
  end

  test "cannot create restaurant without name attribute" do
    restaurant = Restaurant.new(name: "")
    restaurant.valid?
    assert_not restaurant.errors[:name].empty?
  end

  test "can create restaurant with valid description attribute" do
    restaurant = Restaurant.new(description: "Thai restaurant is the greatest place to bring your family")
    restaurant.valid?
    assert restaurant.errors[:description].empty?
  end

  test "cannot create restaurant without description attribute" do
    restaurant = Restaurant.new(description: "")
    restaurant.valid?
    assert_not restaurant.errors[:description].empty?
  end

  test "cannot create restaurant with a description of less than 20 characters" do
    restaurant = Restaurant.new(description: "too short")
    restaurant.valid?
    assert_not restaurant.errors[:description].empty?
  end

  test "cannot create restaurant without a user associated" do
    restaurant = Restaurant.new(name: "Bananas Thai", description: "Thai restaurant is the greatest place to bring your family")
    restaurant.valid?
    assert_not restaurant.errors[:user].empty?
  end

  test "can create restaurant with valid category" do
    restaurant = Restaurant.new(category: CATEGORIES[0])
    restaurant.valid?
    assert restaurant.errors[:category].empty?
  end

  test "cannot create restaurant without category attribute" do
    restaurant = Restaurant.new
    restaurant.valid?
    assert_not restaurant.errors[:category].empty?
  end

  test "cannot create restaurant with empty string for category attribute" do
    restaurant = Restaurant.new(category: "")
    restaurant.valid?
    assert_not restaurant.errors[:user].empty?
  end

  test "cannot create restaurant with category not present in CATEGORIES" do
    restaurant = Restaurant.new(category: "invalid category")
    restaurant.valid?
    assert_not restaurant.errors[:user].empty?
  end
end

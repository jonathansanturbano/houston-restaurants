require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:tierra_del_fuego)
    @user = users(:john)
  end

  test "can see restaurants index" do
    get restaurants_path
    assert_response :success
    assert_select("h1", "Restaurants")
    assert_select("article.restaurant-card", count: Restaurant.count)
  end

  test "can see restaurant show" do
    get restaurant_path(@restaurant)
    assert_response :success
    assert_select("h1", @restaurant.name)
  end

  test "can create new restaurant" do
    sign_in @user
    get new_restaurant_path
    assert_response :success
    assert_select("h1", "Add new restaurant")
    assert_difference("Restaurant.count", +1) do
      post restaurants_path, params: { restaurant: { name: "Pho Dac Biet", description: "Southern Vietnamese comfort food in Houston", category: "Vietnamese" } }
    end
    assert_redirected_to restaurant_path(Restaurant.last)
  end

  test "can update restaurant as owner of restaurant" do
    sign_in @user
    get edit_restaurant_path(@restaurant)
    assert_response :success
    assert_select("h1", "Update information on #{@restaurant.name}")
    patch restaurant_path(@restaurant), params: {restaurant: {name: "Tierra del Hielo"}}
    @restaurant.reload
    assert_equal @restaurant.name, "Tierra del Hielo"
    assert_redirected_to restaurant_path(@restaurant)
  end

  test "can destroy restaurant as owner of restaurant" do
    sign_in @user
    get restaurant_path(@restaurant)
    assert_difference("Restaurant.count", -1) do
      delete restaurant_path(@restaurant)
    end
    assert_redirected_to restaurants_path
  end
end

require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:tierra_del_fuego)
    @user = users(:john)
  end

  test "can see restaurant index" do
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

  test "can create restaurant" do
    sign_in @user
    get new_restaurant_path
    assert_response :success
    assert_select("h1", "Add new restaurant")
    assert_difference("Restaurant.count", +1) do
      post restaurants_path, params: { restaurant: { name: "Pho Dac Biet", description: "Southern Vietnamese comfort food in Houston", category: "Vietnamese", image: fixture_file_upload("files/tierra.jpeg", "image/jpeg") } }
    end
    assert_redirected_to restaurant_path(Restaurant.last)
    assert_equal "tierra.jpeg", Restaurant.last.image.filename.to_s
  end

  test "redirected if trying to create restaurant without signing in" do
    get new_restaurant_path
    assert_response :redirect
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

  test "cannot update restaurant if not owner of restaurant" do
    sign_in @user
  end

  test "can destroy restaurant as owner of restaurant" do
    sign_in @user
    get restaurant_path(@restaurant)
    assert_difference("Restaurant.count", -1) do
      delete restaurant_path(@restaurant)
    end
  end

  test "cannot destroy restaurant if not owner of restaurant" do
    sign_in @user
    not_my_restaurant = restaurants(:guitarra_de_cazon)
    get restaurant_path(not_my_restaurant)
    assert_raises(Pundit::NotAuthorizedError) do
      delete restaurant_path(not_my_restaurant)
    end
  end

  test "can search for restaurants by category" do
    get restaurants_path, params: {category: "Mexican"}
    assert_select("h2", text: "Tierra del Fuego", count: 1)
    assert_select("h2", text: "Guitarra de Cazon", count: 0)
  end
end

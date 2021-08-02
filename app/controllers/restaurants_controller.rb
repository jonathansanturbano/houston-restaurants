class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:category].present?
      @restaurants = policy_scope(Restaurant).where(category: params[:category])
    else
      @restaurants = policy_scope(Restaurant)
    end
    respond_to do |format|
      format.html
      format.text { render partial: 'restaurants/list', locals: { restaurants: @restaurants }, formats: [:html] }
    end
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize @restaurant
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @restaurant.user = current_user
    @restaurant.update(restaurant_params)
    redirect_to @restaurant
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :category)
  end
end

class FoodsController < ApplicationController
  before_action :find_food, only: [:show, :destroy]
  before_action :require_admin, only: [:create, :destroy]

  def new
    @food = Food.new
    @food.images.build
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:notice] = t 'flash.food.success'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @q = Food.ransack(params[:q])
    @foods = @q.result
    if params[:q].present? && !params[:q][:price].empty?
      range = Settings.range_price["range_#{params[:q][:price]}"]
      @foods = @foods.by_price(range.first, range.last)
    end
    @foods = @foods.page(params[:page] || Settings.paginate.default_page).per(params[:page_size] || Settings.paginate.default_per_page)
  end

  def show
    @reviews = @food.reviews.all.order(created_at: :desc)
  end

  def destroy
    if @food.destroy
      flash[:success] = t 'flash.food.delete'
    else
      flash[:notice] = t 'flash.food.notdelete'
    end
    redirect_to root_path
  end

  private

  def food_params
    params.require(:food).permit :name, :description, :price, :category_id, images_attributes: [:image]
  end

  def find_food
    @food = Food.find_by id: params[:id]
    return if @food.present?

    flash[:danger] = t 'flash.food.notfound'
    redirect_to root_url
  end
end

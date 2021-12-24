class HomeController < ApplicationController
  def index
    @foods = Food.all.order(name: :asc)
  end
end

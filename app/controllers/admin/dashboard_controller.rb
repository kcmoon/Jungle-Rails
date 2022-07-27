class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["HTTP_AUTH_USER"], password: ENV["HTTP_AUTH_PASS"]
  
  # Access date from Category and Product tables
  def show
    @category = Category.all.count
    @products = Product.all.count
  end
end

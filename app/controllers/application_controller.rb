class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart
  helper_method :current_user, :current_admin, :cart_item_count

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def cart_item_count
    @cart_item_count ||= session[:cart].values.sum if session[:cart]
  end
end

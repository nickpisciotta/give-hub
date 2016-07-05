class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  before_action :set_cart, :authorize!
  helper_method :current_user, :current_admin, :cart_item_count

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def cart_item_count
    @cart_item_count ||= session[:cart].values.sum if session[:cart]
  end

  private
  def authorize!
    redirect_to(root_url, warning: "You are not authorized") unless authorized?
  end

  def authorized?
    current_permission.allow?
  end

  def current_permission
    # byebug
    charity = Charity.find_by(slug: params[:charity_slug]) || nil
    charity_id = charity.id if charity
    @current_permission ||= PermissionsService.new(current_user, params[:controller], params[:action], charity_id)
  end
end

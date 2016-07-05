class Admin::UsersController < ApplicationController

  def index
    @charities = current_user.charities_to_display
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_roles = @user.roles_to_display(current_user)
  end

end

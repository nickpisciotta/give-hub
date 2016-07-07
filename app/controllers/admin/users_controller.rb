class Admin::UsersController < ApplicationController

  def index

    @charities = DisplayPresenter.charities_to_display(current_user)
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_roles = DisplayPresenter.roles_to_display(@user, current_user)
  end

end

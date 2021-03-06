class Admin::DashboardController < ApplicationController

  def index
    if current_user.platform_admin?
      @pending_charities = Charity.all_pending_charities
      @active_charities = Charity.all_active_charities
      @inactive_charities = Charity.all_inactive_charities
      @suspended_charities = Charity.all_suspended_charities
    else
      @user_charities = DisplayPresenter.charities_to_display(current_user)
    end
  end

end

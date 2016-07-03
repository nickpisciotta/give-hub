class Admin::DashboardController < ApplicationController

  def index
    @charities = current_user.charities_to_display
  end

end

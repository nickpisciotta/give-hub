class Admin::Charity::DashboardsController < Admin::BaseController

  def show
    @charity = Charity.find_by(slug: params[:charity_slug])
  end
end

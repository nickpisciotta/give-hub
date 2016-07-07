class Admin::Charity::AnalyticsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])

  end

end

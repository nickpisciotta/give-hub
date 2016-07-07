class Admin::Charity::AnalyticsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @analytics = AnalyticsPresenter.get_data

  end

end

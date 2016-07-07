class Admin::Charity::AnalyticsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @analytics_ids = AnalyticsPresenter.new(@charity).get_id_data
    # @analytics_data = AnalyticsPresenter.new(@charity).get_data

  end

end

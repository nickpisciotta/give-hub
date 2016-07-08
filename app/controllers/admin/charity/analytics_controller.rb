class Admin::Charity::AnalyticsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @donation_totals = AnalyticsPresenter.new(@charity).donation_total
    @needs_category = AnalyticsPresenter.new(@charity).need_by_category
    @donation_dates = AnalyticsPresenter.new(@charity).total_donations_by_day
    @need_item_count = AnalyticsPresenter.new(@charity).recipient_need_totals
  end

end

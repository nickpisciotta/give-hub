class Admin::Charity::DonationsController < Admin::BaseController
  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @donations = @charity.recipients.need_items.donation_items.donations
  end
end

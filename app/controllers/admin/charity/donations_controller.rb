class Admin::Charity::DonationsController < Admin::BaseController
  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @donations = @charity.donations
  end

  def show
    @charity = Charity.find_by(slug: params[:charity_slug])
    @donation = @charity.donations.find(params[:id])
    byebug
  end
end

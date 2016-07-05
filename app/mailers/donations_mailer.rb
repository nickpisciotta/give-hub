class DonationsMailer < ApplicationMailer
  default from: "refugeerestore@gmail.com"

  def donation_email(info_hash)
    @user = info_hash[:current_user]
    @needs = info_hash[:needs]
    @session = info_hash[:session]
    @total_price = info_hash[:total_price]
    @dashboard_url = info_hash[:dashboard_url]
    mail(to: @user.email, subject: "Your Donation Confirmation!")
  end
end

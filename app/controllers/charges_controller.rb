class ChargesController < ApplicationController
  before_action :order_amount, only: [:new, :create]

  def new
    @amount = @cart.total_price
  end

  def create
    @amount = @cart.total_price
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount.to_i,
      :description => "GiveHub",
      :currency => "usd"
    )
    # order = Order.last
    # order.update_status_paid
    flash[:success] = "Donation was successfully placed"
    session.delete(:cart)
    redirect_to donations_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

    def order_amount
      @amount = Donation.last.total
    end

end

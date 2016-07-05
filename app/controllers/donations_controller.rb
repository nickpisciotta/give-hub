class DonationsController < ApplicationController

  def index
    if !current_user
      flash[:info] = "Please login to see your donation history."
      redirect_to login_path
    else
      @donations = current_user.donations
    end
  end

  def show
    @donation = Donation.find(params[:id])
    if @donation.user != current_user
      flash[:info] = "No donation found."
      redirect_to root_path
    end
  end

  def new
    @needs = @cart.get_need_list_from_cart
  end

  def create
    @cart_need_items = @cart.get_need_items_hash
    @donation = Donation.new(user_id: current_user.id)
    if @donation.save
      @cart_need_items.each do |need_item, quantity|
        @donation.donation_items.create(quantity: quantity, need_item: need_item, donation: @donation)
      end
      flash[:success] = "Your donation, with ID #{@donation.id}, was received. Thank you!"
      DonationsMailer.donation_email({
        current_user: current_user,
        needs: @cart.get_need_list_from_cart,
        session: session,
        total_price: @cart.total_price,
        dashboard_url: dashboard_url}).deliver_now
      session[:cart] = {}
      redirect_to donations_path
    else
      flash.now[:warning] = "Something went wrong with your donation confirmation."
      render :new
    end
  end
end

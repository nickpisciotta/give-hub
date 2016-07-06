class CharitiesController < ApplicationController

  def index
    @charities = Charity.all_active_charities
  end

  def show
    @charity = Charity.find_by(slug: params[:charity_slug])
    if @charity && @charity.active?
      @recipients = @charity.active_recipients
      @featured = @recipients.shuffle.take(4)
    else
      flash[:danger] =
      "Sorry, it seems that is not an active charity."
      redirect_to root_path and return
    end

  end

  def new
    @charity = Charity.new
    @cause_options = Cause.form_options
  end

  def create
    @charity = Charity.new(charity_params)
    if @charity.save
      @charity.create_charity_owner(current_user)
      @charity.causes_charities.create(causes_charities_params)
      redirect_to dashboard_path
    else
      render :new
    end
  end


  private

  def charity_params
    params.require(:charity).permit(:name, :description, :charity_photo, :tagline, :causes_charities)
  end

  def causes_charities_params
    params.require(:causes_charities).permit(:cause_id)
  end





end

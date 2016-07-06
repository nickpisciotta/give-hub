class Admin::Charity::CausesCharitiesController < Admin::BaseController

  def new
    @charity = Charity.find_by(slug: params[:charity_slug])
    @cause_options = Cause.form_options
    @causes_charity = @charity.causes_charities.new
  end

  def create
    @charity = Charity.find_by(slug: params[:charity_slug])
    @cause_charity = @charity.causes_charities.new(causes_charity_params)
    if @cause_charity.save
      redirect_to admin_charity_dashboard_path(@charity.slug)
    else
      render :new
    end
  end

  private
    def causes_charity_params
      params.require(:causes_charity).permit(:cause_id)
    end
end

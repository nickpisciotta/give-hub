class Admin::Charity::CharitiesController <ApplicationController

  def edit
    @charity = Charity.find(params[:id])
  end

  def update
    @charity = Charity.find(params[:id])
    @charity.update(charity_params)
    if current_user.platform_admin?
      redirect_to admin_dashboard_path
    else
      redirect_to admin_charity_dashboard_path(@charity.slug)
    end
  end

  private

  def charity_params
    params.require(:charity).permit(:name, :description,:slug, :status_id, :charity_photo_file_name)
  end


end

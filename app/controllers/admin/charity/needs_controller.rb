class Admin::Charity::NeedsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @needs = @charity.needs
  end

  def show
    @need = Need.find(params[:id])
  end

  def new
    @needs_category_options = NeedsCategory.form_options
    @need = Need.new
  end

  def create
    @charity = Charity.find_by(slug: params[:charity_slug])
    @need = @charity.needs.new(need_params)
    if @need.save
      redirect_to admin_charity_need_path(@charity.slug, @need)
    else
      render :new
    end
  end

  def edit
    @needs_category_options = NeedsCategory.form_options
    @need = Need.find(params[:id])
  end

  def update
    @need = Need.find(params[:id])
    if @need.update(need_params)
      flash[:success] = "Your updates have been saved"
      redirect_to admin_charity_need_path(@need.charity.slug, @need)
    else
      render :edit
    end
  end

  private

  def need_params
    params.require(:need).permit(:name, :description, :price, :needs_category_id, :charity_id, :status_id)
  end

end

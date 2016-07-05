class Admin::Charity::NeedItemsController < Admin::BaseController

  def new
    @charity = Charity.find_by(slug: params[:charity_slug])
    @needs = @charity.needs.form_options
    @recipient = @charity.recipients.find(params[:recipient_id])
    @need_item = @recipient.need_items.new
  end

  def create
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipient = @charity.recipients.find(params[:recipient_id])
    @need_item = @recipient.need_items.new(need_item_params)
    if @need_item.save
      redirect_to admin_charity_recipient_path(@charity.slug, @recipient)
    else
      render :new
    end
  end

  def edit
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipient = Recipient.find(params[:id])
    @need_item = NeedItem.find(params[:id])
    @needs = [[@need_item.need.name, @need_item.need.id]]
  end

  def update
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipient = @charity.recipients.find(params[:recipient_id])
    @need_item = @recipient.need_items.find(params[:id])
    if @need_item.update(need_item_params)
      flash[:success] = "Your updates have been saved"
      redirect_to admin_charity_recipient_path(@charity.slug, @recipient)
    else
      render :edit
    end
  end

  private
    def need_item_params
      params.require(:need_item).permit(:quantity, :recipient_id,
                                        :deadline, :need_id)
    end
end

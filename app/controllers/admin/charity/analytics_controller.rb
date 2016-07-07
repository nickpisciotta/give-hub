class Admin::Charity::AnalyticsController < Admin::BaseController
  # respond_to :json
  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @analytics = {"Merchant" => {items: 1, customers: 12, invoices: 3, average_price: 4}, "All" => {items: 4, customers: 11, invoices: 1, average_price: 1}}

  end


  #
  # def index
  #   @top_three = NeighborhoodAnalyst.top_three_neighborhoods(params)
  #   render json: @top_three
  # end


end

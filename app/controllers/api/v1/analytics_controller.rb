module Api
  module V1
    class AnalyticsController < ApiController
      respond_to :json

      def index
        @data = AnalyticsPresenter.get_data #params prob
        render json: @data
      end
    end
  end
end

class CausesController < ApplicationController
  def show
    @cause = Cause.find_by(slug: params[:causes_slug])
    @recipients = @cause.active_recipients
    @featured = DisplayPresenter.featured_recipients
  end
end

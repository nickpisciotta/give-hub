class NeedsCategoriesController < ApplicationController

  def show
    @needs_category = NeedsCategory.find_by(slug: params[:needs_category_slug])
    @recipients = @needs_category.active_recipients
    @featured = DisplayPresenter.featured_recipients(@recipients)
  end

end

class HomesController < ApplicationController

  def index
    @charities = Charity.all
  end

  def show
    @home_show = true
    @charities = Charity.all
    @causes = Cause.all
    @needs_categories = NeedsCategory.all
  end
end

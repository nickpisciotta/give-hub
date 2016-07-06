class NeedsPresenter
  def initialize(needs)
    @needs = needs
  end

  def form_options
    @needs.pluck(:name).zip(@needs.pluck(:id))
    # @needs.all.map{ |charity_need| [ charity_need.name, charity_need.id ] }
  end
end

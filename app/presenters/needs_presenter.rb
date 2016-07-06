class NeedsPresenter
  def initialize(needs)
    @needs = needs
  end

  def form_options
    @needs.all.map{ |charity_need| [ charity_need.name, charity_need.id ] }
  end
end

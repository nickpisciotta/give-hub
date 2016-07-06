class FormPresenter
  def initialize(selection_group)
    @selection_group = selection_group
  end

  def form_options
    @selection_group.pluck(:name).zip(@selection_group.pluck(:id))
  end
end

class FormPresenter
  def initialize(selection_group)
    @selection_group = selection_group
  end

  def form_options
    @selection_group.pluck(:name).zip(@selection_group.pluck(:id))
  end

  def charity_form_options(user)
    if user.platform_admin?
      @selection_group.pluck(:name).zip(@selection_group.pluck(:id))
    else
      user.charities.pluck(:name).zip(user.charities.pluck(:id))
    end
  end

  def role_form_options(user)
    if user.platform_admin?
      @selection_group.pluck(:name).zip(@selection_group.pluck(:id))
    else
      [["Business Admin", 4],["Business Owner", 3]]
    end
  end
end

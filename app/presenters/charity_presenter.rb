class CharityPresenter < BasePresenter
  presents :charity

  def status_buttons
    if charity.active?
      template.deactivate_charity_link(charity)
    elsif charity.inactive?
      template.activate_charity_link(charity)
    elsif charity.suspended?
      template.deactivate_charity_link(charity) +
      template.activate_charity_link(charity)
    end
  end

end

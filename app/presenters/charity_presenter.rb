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

  def add_charity_link(form)
    if template.current_user
      form.submit "Submit Charity", class: "btn btn-primary round"
    else
      template.link_to "Login or Create Account to Submit A Charity", template.login_path, class: "btn btn-primary round"
    end
  end

end

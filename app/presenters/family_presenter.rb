class FamilyPresenter < BasePresenter
  presents :family

  def retired_or_active_progress_bar
    if !family.retired?
      template.content_tag(:h4, "Welcome them to the United States.  Donate these items to help them set up their new home.") +
      template.content_tag(:h5, "This family needs a total of #{ template.currency family.value_of_supplies_needed} in donations.")
    else
      template.content_tag(:h4, "Thank you for welcoming them to the United States.") +
      template.content_tag(:h5, "This family received #{ template.currency family.value_of_supplies_purchased} in donations.")
    end
  end
end

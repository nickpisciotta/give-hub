class NeedPresenter < BasePresenter
  presents :need

  def status_buttons
    if need.active?
      template.deactivate_need_link(need) +
      if template.current_user.platform_admin?
        template.suspend_need_link(need)
      end
    elsif need.inactive?
      template.activate_need_link(need) +
      if template.current_user.platform_admin?
        template.suspend_need_link(need)
      end
    else
      template.deactivate_need_link(need) +
      if template.current_user.platform_admin?
        template.activate_need_link(need)
      end
    end
  end
end

class DisplayPresenter

  def self.charities_to_display(current_user)
    current_user.platform_admin? ? Charity.all : current_user.charities
  end

  def self.roles_to_display(user, current_user)
    if current_user.platform_admin?
      user.user_roles
    else
      ids = current_user.charities.joins(:user_roles).pluck("user_roles_charities.id")
      user.user_roles.where(id: ids)
    end
  end

  def self.featured_recipients(recipients)
    recipients.shuffle.take(4)
  end

end

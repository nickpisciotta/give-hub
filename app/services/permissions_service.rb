class PermissionsService
  def initialize(user, controller, action, charity_id)
    @_user = user || User.new
    @_controller = controller
    @_action = action
    @_charity_id = charity_id
  end

  def allow?
    if user.platform_admin?
      platform_admin_permissions
    elsif user.business_owner?
      business_owner_permissions
    elsif user.business_admin?
      business_admin_permissions
    else
      registered_user_permissions
    end
  end

  private
  def action
    @_action
  end

  def controller
    @_controller
  end

  def user
    @_user
  end

  def charity_id
    @_charity_id
  end

  def registered_user_permissions
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_categories" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
  end

  def business_admin_permissions
    if user.charities.exists?(id: charity_id)
      return true if controller == "admin/charity/needs" && action == "index"
      return true if controller == "admin/charity/needs" && action == "show"
      return true if controller == "admin/charity/needs" && action == "edit"
      return true if controller == "admin/charity/needs" && action == "update"
      return true if controller == "admin/charity/needs" && action == "new"
      return true if controller == "admin/charity/needs" && action == "create"
      return true if controller == "admin/charity/needs" && action == "edit"
      return true if controller == "admin/charity/needs" && action == "update"
      return true if controller == "admin/charity/recipients" && action == "index"
      return true if controller == "admin/charity/recipients" && action == "show"
      return true if controller == "admin/charity/recipients" && action == "edit"
      return true if controller == "admin/charity/recipients" && action == "update"
      return true if controller == "admin/charity/recipients" && action == "new"
      return true if controller == "admin/charity/recipients" && action == "destroy"
      return true if controller == "admin/charity/recipients" && action == "create"
      return true if controller == "admin/charity/dashboards" && action == "show"
    end
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "admin/dashboard" && action == "index"
    return true if controller == "admin/users" && action == "index"
    return true if controller == "admin/users" && action == "show"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_categories" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
    return true if controller == "admin/user_roles" && action == "new"
    return true if controller == "admin/user_roles" && action == "create"
  end

  def business_owner_permissions
    if user.charities.exists?(id: charity_id)
      return true if controller == "admin/charity/recipients" && action == "index"
      return true if controller == "admin/charity/recipients" && action == "show"
      return true if controller == "admin/charity/recipients" && action == "edit"
      return true if controller == "admin/charity/recipients" && action == "update"
      return true if controller == "admin/charity/recipients" && action == "new"
      return true if controller == "admin/charity/recipients" && action == "destroy"
      return true if controller == "admin/charity/recipients" && action == "create"
      return true if controller == "admin/charity/needs" && action == "index"
      return true if controller == "admin/charity/needs" && action == "show"
      return true if controller == "admin/charity/needs" && action == "edit"
      return true if controller == "admin/charity/needs" && action == "update"
      return true if controller == "admin/charity/needs" && action == "new"
      return true if controller == "admin/charity/needs" && action == "create"
      return true if controller == "admin/charity/needs" && action == "edit"
      return true if controller == "admin/charity/needs" && action == "update"
      return true if controller == "admin/charity/dashboards" && action == "show"
    end
    return true if controller == "admin/user_roles" && action == "new"
    return true if controller == "admin/user_roles" && action == "create"
    return true if controller == "admin/users" && action == "index"
    return true if controller == "admin/users" && action == "show"
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "admin/dashboard" && action == "index"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_categories" && action == "show"
  end

  def platform_admin_permissions
    return true if controller == "admin/charity/needs" && action == "index"
    return true if controller == "admin/charity/needs" && action == "show"
    return true if controller == "admin/charity/needs" && action == "edit"
    return true if controller == "admin/charity/needs" && action == "update"
    return true if controller == "admin/charity/needs" && action == "new"
    return true if controller == "admin/charity/needs" && action == "create"
    return true if controller == "admin/charity/recipients" && action == "index"
    return true if controller == "admin/charity/recipients" && action == "show"
    return true if controller == "admin/charity/recipients" && action == "edit"
    return true if controller == "admin/charity/recipients" && action == "update"
    return true if controller == "admin/charity/recipients" && action == "new"
    return true if controller == "admin/charity/recipients" && action == "destroy"
    return true if controller == "admin/charity/recipients" && action == "create"
    return true if controller == "admin/charity/dashboards" && action == "show"
    return true if controller == "admin/user_roles" && action == "new"
    return true if controller == "admin/user_roles" && action == "create"
    return true if controller == "admin/users" && action == "index"
    return true if controller == "admin/users" && action == "show"
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "admin/dashboard" && action == "index"
    return true if controller == "sessions" && action == "destroy"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_categories" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
  end
end

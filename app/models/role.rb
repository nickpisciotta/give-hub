class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles


  def self.form_options(user)
    if user.platform_admin?
      all.map{ |role| [ role.name, role.id ] }
    else
      [["Business Admin", 4],["Business Owner", 3]]
    end
  end

end

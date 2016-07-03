class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validate :password_correct?, on: :update

  has_many :donations
  has_many :donation_items, through: :donations

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :charities, through: :user_roles

  attr_accessor :current_password

  def roles_to_display(admin_user) #ADD TEST
    if admin_user.platform_admin?
      user_roles
    else
      admin_charities = admin_user.charities
      user_roles.find_all do |role|
        admin_charities.include?(role.charity)
      end
    end
  end

  def charities_to_display #ADD TEST
    platform_admin? ? Charity.all : charities
  end

  def current_admin?
    platform_admin? || business_owner? || business_admin?
  end

  def delete_permission?
    platform_admin? || business_owner?
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def business_owner?
    roles.exists?(name: "business_owner")
  end

  def business_admin?
    roles.exists?(name: "business_admin")
  end

  def role_by_charity(charity)
    user_roles.where(charity_id: charity.id).first
  end


  def password_correct?
    if !password.blank?
      user = User.find_by_id(id)
      if !user.authenticate(current_password)
        errors.add(:current_password, "is incorrect.")
      end
    end
  end
end

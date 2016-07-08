class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, allow_blank: false
  validates :email, presence: true
  validates :password, presence: true
  validate :password_correct?, on: :update

  has_many :donations
  has_many :donation_items, through: :donations

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :charities, through: :user_roles

  attr_accessor :current_password

  def current_admin?
    platform_admin? || business_owner? || business_admin?
  end

  def delete_permission?
    platform_admin? || business_owner?
  end

  def platform_admin?
    roles.exists?(name: "Platform Admin")
  end

  def business_owner?
    roles.exists?(name: "Business Owner")
  end

  def business_admin?
    roles.exists?(name: "Business Admin")
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

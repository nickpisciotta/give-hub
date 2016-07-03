class UserRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :charity
  belongs_to :user

  def name
    role.name
  end
  
end

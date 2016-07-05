class Status < ActiveRecord::Base
  has_many :needs
  has_many :charities
  validates :name, presence: true

end

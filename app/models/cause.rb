class Cause < ActiveRecord::Base
  validates :name, presence: true

  has_many :causes_charities
  has_many :charities, through: :causes_charities
  
  has_many :recipients, through: :charities
  before_create :create_slug

  def create_slug
    self.slug = self.name.parameterize
  end

  def active_recipients
    recipients.find_all { |recipient| !recipient.active_need_items.empty? }
  end

  def self.form_options
    all.map{ |cause| [ cause.name, cause.id ] }
  end

end

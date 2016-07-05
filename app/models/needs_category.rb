class NeedsCategory < ActiveRecord::Base
  validates :name, presence: true
  has_many :needs
  before_create :create_slug
  has_many :need_items, through: :needs
  has_many :recipients, through: :need_items

  def create_slug
    self.slug = self.name.parameterize
  end

  def active_recipients
    recipients.find_all { |recipient| !recipient.active_need_items.empty? }
  end

  def self.form_options
    all.map{ |need_cat| [ need_cat.name, need_cat.id ] }
  end


end

class Recipient < ActiveRecord::Base
  validates :name, presence: true
  #  uniqueness: true
  validates :description, presence: true

  has_many :need_items
  has_many :needs, through: :need_items
  has_many :need_categories, through: :needs
  has_many :donation_items, through: :need_items
  belongs_to :charity

  has_attached_file :recipient_photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '600x600>'
  }
  validates_attachment_content_type :recipient_photo, :content_type => /\Aimage\/.*\Z/

  scope :retired, -> {where(active_need_items == 0)}
  scope :active, -> {where(active_need_items >= 1)}

  def active_need_items
    need_items.find_all { |item| item.active_need_item }
  end

  def need_categories
    needs.map {|need| need.needs_category}.uniq
  end

  def retired?
    arrival_date <= Date.today
  end
end

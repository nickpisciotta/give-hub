class Recipient < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  has_many :need_items
  has_many :needs, through: :need_items
  has_many :donation_items, through: :need_items
  belongs_to :charity

  has_attached_file :recipient_photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '600x600>'
     }, default_url: "https://s3.amazonaws.com/tinystays/avatar-missing.jpeg"

  validates_attachment_content_type :recipient_photo, :content_type => /\Aimage\/.*\Z/

  def active_need_items
    need_items.find_all { |item| item.active_need_item }
  end

  def need_categories
    needs.map {|need| need.needs_category}.uniq
  end

end

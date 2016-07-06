class Need < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :need_items
  has_many :recipients, through: :need_items
  has_many :donation_items, through: :need_items
  belongs_to :needs_category
  belongs_to :charity
  belongs_to :status

  scope :active, -> {where("status_id = ?", 1)}
  scope :inactive, -> {where("status_id = ?", 2)}
  scope :suspended, -> {where("status_id = ?", 3)}

  def active?
    status_id == 1
  end

  def inactive?
    status_id == 2
  end

  def suspended?
    status_id == 3
  end

end

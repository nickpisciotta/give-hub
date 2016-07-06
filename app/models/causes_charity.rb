class CausesCharity < ActiveRecord::Base
  belongs_to :charity
  belongs_to :cause

  accepts_nested_attributes_for :cause

end

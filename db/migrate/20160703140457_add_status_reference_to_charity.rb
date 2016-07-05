class AddStatusReferenceToCharity < ActiveRecord::Migration
  def change
    add_reference :charities, :status, index: true, foreign_key: true
  end
end

class AddReferenceToNeed < ActiveRecord::Migration
  def change
    add_reference :needs, :status, index: true, foreign_key: true
  end
end

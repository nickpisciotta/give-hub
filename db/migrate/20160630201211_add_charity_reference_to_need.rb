class AddCharityReferenceToNeed < ActiveRecord::Migration
  def change
    add_reference :needs, :charity, index: true, foreign_key: true
  end
end

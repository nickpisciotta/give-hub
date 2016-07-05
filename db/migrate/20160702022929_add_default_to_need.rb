class AddDefaultToNeed < ActiveRecord::Migration
  def change
    change_column :needs, :status_id, :integer, :default => 1
  end
end

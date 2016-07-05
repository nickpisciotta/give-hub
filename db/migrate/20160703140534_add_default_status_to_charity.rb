class AddDefaultStatusToCharity < ActiveRecord::Migration
  def change
    change_column :charities, :status_id, :integer, :default => 1
  end
end

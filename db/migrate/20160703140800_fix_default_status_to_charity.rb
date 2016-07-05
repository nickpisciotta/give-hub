class FixDefaultStatusToCharity < ActiveRecord::Migration
  def change
    change_column :charities, :status_id, :integer, :default => 2
  end
end

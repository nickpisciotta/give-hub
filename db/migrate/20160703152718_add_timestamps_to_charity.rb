class AddTimestampsToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :created_at, :datetime
    add_column :charities, :updated_at, :datetime
  end
end

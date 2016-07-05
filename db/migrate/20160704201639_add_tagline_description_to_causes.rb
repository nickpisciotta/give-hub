class AddTaglineDescriptionToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :tagline, :string
    add_column :causes, :description, :string
    add_column :needs_categories, :tagline, :string
    add_column :needs_categories, :description, :string
    add_column :charities, :tagline, :string
  end
end

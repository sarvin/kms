class AddActiveToPublicNavigation < ActiveRecord::Migration
  def change
    add_column :public_navigations, :active, :boolean
    add_index :public_navigations, :active
    add_index :public_navigations, [:navigable_id, :navigable_type], unique: true
  end
end

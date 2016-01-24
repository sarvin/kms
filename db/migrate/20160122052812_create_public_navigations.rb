class CreatePublicNavigations < ActiveRecord::Migration
  def change
    create_table :public_navigations do |t|
      t.integer :order
      t.references :navigable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

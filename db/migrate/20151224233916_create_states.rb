class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :abbreviated_name
      t.string :census_division_name

      t.timestamps null: false
    end
  end
end

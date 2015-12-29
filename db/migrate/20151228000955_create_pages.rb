class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :sub_title
      t.text :body
			t.references :pageable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

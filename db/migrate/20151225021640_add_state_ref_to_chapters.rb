class AddStateRefToChapters < ActiveRecord::Migration
  def change
    add_reference :chapters, :state, index: true, foreign_key: true
  end
end

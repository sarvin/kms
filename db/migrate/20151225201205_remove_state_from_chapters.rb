class RemoveStateFromChapters < ActiveRecord::Migration
  def change
    remove_column :chapters, :state, :text
  end
end

class AddChapterToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :chapter, index: true, foreign_key: true
  end
end

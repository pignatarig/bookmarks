class AddUniqueIdToBookmarks < ActiveRecord::Migration[5.1]
  def change
    add_column :bookmarks, :unique_id, :string
    add_index :bookmarks, :unique_id, unique: true
  end
end

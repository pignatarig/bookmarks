class AddBookmarksSiteId < ActiveRecord::Migration[5.1]
  def change
    add_column :bookmarks, :site_id, :integer, after: :url
  end
end

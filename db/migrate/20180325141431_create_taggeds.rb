class CreateTaggeds < ActiveRecord::Migration[5.1]
  def change
    create_table :taggeds do |t|
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :bookmark, foreign_key: true

      t.timestamps
    end
  end
end

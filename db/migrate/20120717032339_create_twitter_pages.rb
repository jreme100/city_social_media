class CreateTwitterPages < ActiveRecord::Migration
  def change
    create_table :twitter_pages do |t|
      t.integer  :municipality_id
      t.integer  :twitter_id, limit: 8
      t.string   :url

      t.timestamps
    end
  end
end

class CreateFacebookPages < ActiveRecord::Migration
  def change
    create_table :facebook_pages do |t|
      t.integer  :municipality_id
      t.integer  :facebook_id, limit: 8
      t.string   :url
      t.string   :name
      t.integer  :likes
      t.integer  :liked
      t.integer  :checkins
      t.integer  :were_here_count
      t.integer  :talking_about_count
      t.boolean  :can_post,   default: false
      t.boolean  :recommends, default: false
      t.integer  :recommends_count

      t.timestamps
    end
  end
end

class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.integer  :facebook_page_id
      t.integer  :on_id
      t.integer  :likes
      t.integer  :shares
      t.string   :from
      t.text     :body

      t.datetime :fb_created_at
      t.timestamps
    end
  end
end

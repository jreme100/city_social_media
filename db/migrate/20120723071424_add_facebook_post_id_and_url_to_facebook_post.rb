class AddFacebookPostIdAndUrlToFacebookPost < ActiveRecord::Migration
  def change
    add_column :facebook_posts, :fb_object_id, :integer, limit: 8
    add_column :facebook_posts, :fb_url,       :string
  end
end

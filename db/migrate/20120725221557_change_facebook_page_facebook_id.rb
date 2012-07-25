class ChangeFacebookPageFacebookId < ActiveRecord::Migration
  def change
    rename_column :facebook_pages, :facebook_id, :fb_object_id
  end
end

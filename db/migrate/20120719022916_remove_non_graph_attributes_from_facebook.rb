class RemoveNonGraphAttributesFromFacebook < ActiveRecord::Migration
  def change
    remove_column :facebook_pages, :liked
    remove_column :facebook_pages, :recommends
    remove_column :facebook_pages, :recommends_count
  end
end

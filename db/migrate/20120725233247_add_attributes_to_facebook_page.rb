class AddAttributesToFacebookPage < ActiveRecord::Migration
  def change
    rename_column :facebook_pages, :url, :link
    add_column :facebook_pages, :category, :string
    add_column :facebook_pages, :website,  :string
  end
end

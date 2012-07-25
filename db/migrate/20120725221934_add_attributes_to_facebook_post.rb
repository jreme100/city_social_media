class AddAttributesToFacebookPost < ActiveRecord::Migration
  def change
    remove_column :facebook_posts, :fb_created_at
    remove_column :facebook_posts, :fb_url
    remove_column :facebook_posts, :body

    add_column :facebook_posts, :to,           :string
    add_column :facebook_posts, :message,      :string
    add_column :facebook_posts, :picture,      :string
    add_column :facebook_posts, :link,         :string
    add_column :facebook_posts, :name,         :string
    add_column :facebook_posts, :caption,      :string
    add_column :facebook_posts, :description,  :string
    add_column :facebook_posts, :source,       :string
    add_column :facebook_posts, :icon,         :string
    add_column :facebook_posts, :type,         :string
    add_column :facebook_posts, :story,        :string
    add_column :facebook_posts, :application,  :integer
    add_column :facebook_posts, :created_time, :datetime
    add_column :facebook_posts, :updated_time, :datetime
  end
end
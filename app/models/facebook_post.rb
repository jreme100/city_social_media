class FacebookPost < ActiveRecord::Base
  attr_accessible :facebook_page_id,
                  :on_id,
                  :likes,
                  :shares,
                  :from,
                  :body,
                  :fb_created_at

  belongs_to :facebook_page
  belongs_to :on,       class_name: 'FacebookPost'
  has_many   :comments, class_name: 'FacebookPost', foreign_key: 'on_id'
end

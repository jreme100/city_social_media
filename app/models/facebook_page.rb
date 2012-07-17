class FacebookPage < ActiveRecord::Base
  attr_accessible :facebook_id,
                  :url,
                  :name,
                  :likes,
                  :liked,
                  :checkins,
                  :were_here_count,
                  :talking_about_count,
                  :can_post,
                  :recommends,
                  :recommends_count

  belongs_to :municipality
  has_many   :posts, class_name: 'FacebookPost'
end

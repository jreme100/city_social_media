class TwitterPage < ActiveRecord::Base
  attr_accessible :municipality_id,
                  :twitter_id,
                  :url

  belongs_to :municipality
end

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

  @queue = :facebook_page

  belongs_to :municipality

  has_many   :posts, class_name: 'FacebookPost'

  after_create :enqueue_facebook_page

  def get_facebook_graph_data

  end

  class << self
    def perform(page)
      facebook_page = self.find_by_id(page)
      facebook_page.get_facebook_graph_data
      facebook_page.save!
    end
  end

private
  def enqueue_facebook_page
    Resque.enqueue(FacebookPage, self.id)
  end
end

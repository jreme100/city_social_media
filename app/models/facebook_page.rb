class FacebookPage < ActiveRecord::Base
  class NoFacebookID < StandardError; end

  attr_accessible :facebook_id,
                  :url,
                  :name,
                  :likes,
                  :checkins,
                  :were_here_count,
                  :talking_about_count,
                  :can_post

  @queue = :facebook_page

  belongs_to :municipality

  has_many   :posts, class_name: 'FacebookPost'

  after_create :enqueue_facebook_page

  def get_facebook_graph_data
    raise NoFacebookID unless self.facebook_id
    set_attributes(::FB.get_object(self.facebook_id).symbolize_keys)
    save!
    reload
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

  def set_attributes(attributes)
    self.url                 = attributes[:link]
    self.name                = attributes[:name]
    self.likes               = attributes[:likes]
    self.checkins            = attributes[:checkins]
    self.were_here_count     = attributes[:were_here_count]
    self.talking_about_count = attributes[:talking_about_count]
  end
end

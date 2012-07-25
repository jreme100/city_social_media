class FacebookPost < ActiveRecord::Base
  attr_accessible :likes,
                  :shares,
                  :from,
                  :body,
                  :fb_created_at,
                  :fb_object_id,
                  :fb_url

  @queue = :facebook_page

  belongs_to :facebook_page
  belongs_to :on,       class_name: 'FacebookPost'
  has_many   :comments, class_name: 'FacebookPost', foreign_key: 'on_id'

  def full_fbid
    if self.on.present?
      [ self.on.facebook_page.facebook_id, on.fb_object_id, self.fb_object_id ].compact.join('_')
    else
      [ self.facebook_page.facebook_id, self.fb_object_id ].compact.join('_')
    end
  end

  class << self
    def get_new
      FacebookPage.find_each { |page| Resque.enqueue(FacebookPost, page.facebook_id) }
    end

    def perform(page_id)
      ::FB.graph_call( page_id << '/posts' ).each do |fb_post|
        fb_post.symbolize_keys!
        local = FacebookPost.find_by_fb_object_id( fb_post[:id].to_fbid ) || FacebookPost.new
        local.set_attributes( fb_post )
        local.save!
      end
    end
  end

private
  def set_attributes(attributes)
    self.likes         = attributes[:likes].try(:[],:count)
    self.shares        = attributes[:shares].try(:[],:count)
    self.from          = attributes[:from].try(:[],:name)
    self.body          = attributes[:message] || attributes[:description] || attributes[:caption]
    self.fb_created_at = attributes[:created_time]
    self.fb_object_id  = attributes[:id].to_fbid
    self.fb_url        = attributes[:link]

    if attributes[:comments][:data]
      attributes[:comments][:data].each do |comment|
        parent = attributes[:id].split('_').last.to_i
        local_comment = FacebookPost.find_by_on_id( parent ) || FacebookPost.new( on_id: parent )
        self.from          = attributes[:from].try(:[],:name)
        self.body          = attributes[:message] || attributes[:description] || attributes[:caption]
        self.fb_created_at = attributes[:created_time]
        self.fb_object_id  = attributes[:id].to_fbid
      end

    end
  end
end

class String
  def to_fbid
    self..split('_').last.to_i
  end
end

class FacebookPost < ActiveRecord::Base
  attr_accessible :fb_object_id,
                  :from,
                  :to,
                  :message,
                  :picture,
                  :link,
                  :name,
                  :caption,
                  :description,
                  :source,
                  :icon,
                  :type,
                  :likes,
                  :story,
                  :application,
                  :created_time,
                  :updated_time,
                  :shares,
                  :created_at,
                  :updated_at

  @queue = :facebook_page

  belongs_to :facebook_page
  belongs_to :on,       class_name: 'FacebookPost'
  has_many   :comments, class_name: 'FacebookPost', foreign_key: 'on_id'

  def full_fbid
    if self.on.present?
      [ self.on.facebook_page.fb_object_id, on.fb_object_id, self.fb_object_id ].compact.join('_')
    else
      [ self.facebook_page.fb_object_id, self.fb_object_id ].compact.join('_')
    end
  end

  class << self
    def get_new
      FacebookPage.find_each { |page| Resque.enqueue(FacebookPost, page.fb_object_id) }
    end

    def perform(page_id = nil)
      raise FacebookPage::NoFacebookID unless page_id
      p page_id.to_s << '/posts'
      p ::FB
      ::FB.graph_call( page_id.to_s << '/posts' ).each do |fb_post|
        fb_post.symbolize_keys!
        local = FacebookPost.find_by_fb_object_id( fb_post[:id].to_fbid ) || FacebookPost.new
        local.set_attributes( fb_post )
        local.save!
      end
    end
  end

private
  def set_attributes(attributes)
    self.fb_object_id  = attributes[:id].to_fbid
    self.from          = attributes[:from].try(:[],:name)
    self.to            = attributes[:to].try(:[],:name)
    self.message       = attributes[:message]
    self.picture       = attributes[:picture]
    self.link          = attributes[:link]
    self.name          = attributes[:name]
    self.caption       = attributes[:caption]
    self.description   = attributes[:description]
    self.source        = attributes[:source]
    self.icon          = attributes[:icon]
    self.type          = attributes[:type]
    self.likes         = attributes[:likes].try(:[],:count)
    self.story         = attributes[:story]
    self.application   = attributes[:application].try(:[],:id)
    self.created_time  = DateTime.iso8601 attributes[:created_time]
    self.updated_time  = DateTime.iso8601 attributes[:updated_time]
    self.shares        = attributes[:shares].try(:[],:count)

    if attributes[:comments][:data]
      attributes[:comments][:data].each do |comment|
        parent = attributes[:id].split('_').last.to_i
        local_comment = FacebookPost.find_by_on_id( parent ) || FacebookPost.new( on_id: parent )
        self.from          = attributes[:from].try(:[],:name)
        self.body          = attributes[:message]
        self.fb_created_at = attributes[:created_time]
        self.fb_object_id  = attributes[:id].to_fbid
      end

    end
  end
end

class String
  def to_fbid
    self.split('_').last.to_i
  end
end

class Municipality < ActiveRecord::Base
  attr_accessible :geographic_area,
                  :state,
                  :url,
                  :population_estimate,
                  :region,
                  :size,
                  :facebook,
                  :twitter,
                  :multiple_accounts,
                  :multiple_account_notes

  has_one :facebook_page
  has_one :twitter_page

  def set_attributes(attributes)
    self.geographic_area        = attributes[:geographic_area]
    self.state                  = attributes[:state]
    self.region                 = attributes[:region]
    self.population_estimate    = attributes[:population_estimate]
    self.size                   = attributes[:size]
    self.url                    = attributes[:url]
    self.facebook               = attributes[:facebook]
    self.twitter                = attributes[:twitter]
    self.multiple_accounts      = attributes[:multiple_accounts]
    self.multiple_account_notes = attributes[:multiple_account_notes]

    set_facebook_page_attributes(attributes) if attributes[:facebook]
    set_twitter_page_attributes(attributes) if attributes[:twitter]
  end

private
  def set_facebook_page_attributes(attributes)
    self.build_facebook_page if self.new_record?
    self.facebook_page.facebook_id = attributes[:facebook_id]
    self.facebook_page.url         = attributes[:facebook_url]
    self.facebook_page.can_post    = attributes[:facebook_can_post]
  end

  def set_twitter_page_attributes(attributes)
    self.build_twitter_page if self.new_record?
    self.twitter_page.twitter_id = attributes[:twitter_id]
    self.twitter_page.url        = attributes[:twitter_url]
  end
end

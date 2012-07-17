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
end

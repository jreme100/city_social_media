require 'spec_helper'

describe Municipality do
  context 'ATTRIBUTES' do
    it { should respond_to(:geographic_area) }
    it { should respond_to(:state) }
    it { should respond_to(:url) }
    it { should respond_to(:population_estimate) }
    it { should respond_to(:region) }
    it { should respond_to(:size) }
    it { should respond_to(:facebook) }
    it { should respond_to(:twitter) }
    it { should respond_to(:multiple_accounts) }
    it { should respond_to(:multiple_account_notes) }
  end

  context 'RELATIONS' do
    it { should respond_to(:facebook_page) }
    it { should respond_to(:twitter_page) }
  end
end

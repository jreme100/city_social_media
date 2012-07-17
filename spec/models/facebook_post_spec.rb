require 'spec_helper'

describe FacebookPost do
  context 'ATTRIBUTES' do
    it { should respond_to(:facebook_page_id) }
    it { should respond_to(:on_id) }
    it { should respond_to(:likes) }
    it { should respond_to(:shares) }
    it { should respond_to(:from) }
    it { should respond_to(:body) }
    it { should respond_to(:fb_created_at) }
  end

  context 'RELATIONS' do
    it { should respond_to(:facebook_page) }
    it { should respond_to(:comments) }
    it { should respond_to(:on) }
  end
end

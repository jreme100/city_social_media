require 'spec_helper'

describe TwitterPage do
  context 'ATTRIBUTES' do
    it { should respond_to(:twitter_id) }
    it { should respond_to(:url) }
  end

  context 'RELATIONS' do
    it { should respond_to(:municipality) }
  end
end

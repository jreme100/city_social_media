require 'spec_helper'

describe FacebookPage do
  context 'ATTRIBUTES' do
    it { should respond_to(:facebook_id) }
    it { should respond_to(:url) }
    it { should respond_to(:name) }
    it { should respond_to(:likes) }
    it { should respond_to(:liked) }
    it { should respond_to(:checkins) }
    it { should respond_to(:were_here_count) }
    it { should respond_to(:talking_about_count) }
    it { should respond_to(:can_post) }
    it { should respond_to(:recommends) }
    it { should respond_to(:recommends_count) }
  end

  context 'RELATIONS' do
    it { should respond_to(:municipality) }
  end
end

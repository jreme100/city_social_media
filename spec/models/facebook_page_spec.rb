require 'spec_helper'

describe FacebookPage do
  context 'ATTRIBUTES' do
    it { should respond_to(:facebook_id) }
    it { should respond_to(:url) }
    it { should respond_to(:name) }
    it { should respond_to(:likes) }
    it { should respond_to(:checkins) }
    it { should respond_to(:were_here_count) }
    it { should respond_to(:talking_about_count) }
    it { should respond_to(:can_post) }
  end

  context 'RELATIONS' do
    it { should respond_to(:municipality) }
    it { should respond_to(:posts) }
  end

  context 'LIFECYCLE' do
    describe 'before_create' do
      describe '#facebook_graph_data' do
        subject { FacebookPage.create }

        it 'sets the facebook_id' do
          subject.facebook_id.should_not
        end

        it 'sets the url' do

        end

        it 'sets the name' do

        end

        it 'sets the likes' do

        end

        it 'sets the checkins' do

        end

        it 'sets the were_here_count' do

        end

        it 'sets the talking_about_count' do

        end

        it 'sets the can_post' do

        end

        it 'creates facebook_posts if they are available' do

        end

      end
    end
  end
end

#AllentownPA?fields=name,link,can_post,likes,were_here_count,talking_about_count,checkins
#{
#  "name": "Allentown Pennsylvania",
#  "link": "http://www.facebook.com/AllentownPA",
#  "can_post": true,
#"likes": 6616,
#  "were_here_count": 1280,
#  "talking_about_count": 110,
#  "checkins": 266,
#  "id": "175471555835011"
#}
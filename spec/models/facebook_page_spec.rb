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
    describe 'after_create' do
      describe '#enqueue' do
        it 'places the facebook_page in the harvesting queue' do
          Resque.should_receive(:enqueue).with(FacebookPage, anything)
          FacebookPage.create
        end
      end
    end
  end

  context 'INSTANCE METHODS' do

  end

  context 'CLASS METHODS' do
    describe 'perform' do
      it 'finds the instance and calls get_facebook_graph_data on it' do
        FacebookPage.any_instance.should_receive(:get_facebook_graph_data)
        FacebookPage.any_instance.stub(:enqueue_facebook_page)
        FacebookPage.perform(FacebookPage.create.id)
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
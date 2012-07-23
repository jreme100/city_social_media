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
    before { FacebookPage.any_instance.stub(:enqueue_facebook_page) }

    describe '#get_facebook_graph_data' do
      use_vcr_cassette
      subject { FacebookPage.create(facebook_id: 175471555835011).get_facebook_graph_data }

      it 'raises a NoFacebookID when on is missing' do
        expect { FacebookPage.new.get_facebook_graph_data }.to raise_error(FacebookPage::NoFacebookID)
      end

      it 'sets the url' do
        #  link: "http://www.facebook.com/AllentownPA"
        subject.url.should eql('http://www.facebook.com/AllentownPA')
      end

      it 'sets the name' do
        #  name: "Allentown Pennsylvania"
        subject.name.should eql('Allentown Pennsylvania')
      end

      it 'sets the likes' do
        #  likes: 6616
        subject.likes.should be > 6615
      end

      it 'sets the checkins' do
        #  checkins: 266
        subject.checkins.should be > 265
      end

      it 'sets the were_here_count' do
        #  were_here_count: 1280
        subject.were_here_count.should be > 1275
      end

      it 'sets the talking_about_count' do
        #  talking_about_count: 110
        subject.talking_about_count.should be > 100
      end

      it 'sets the can_post' do
        pending 'must authenticate as a user to see the can_post setting.'
        #  can_post: true
        subject.can_post?.should be_true
      end
    end
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






#  "id": "175471555835011"
#}
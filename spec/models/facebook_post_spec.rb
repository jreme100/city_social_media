require 'spec_helper'

describe FacebookPost do
  context 'ATTRIBUTES' do
    it { should respond_to(:fb_object_id) }
    it { should respond_to(:from) }
    it { should respond_to(:to) }
    it { should respond_to(:message) }
    it { should respond_to(:picture) }
    it { should respond_to(:link) }
    it { should respond_to(:name) }
    it { should respond_to(:caption) }
    it { should respond_to(:description) }
    it { should respond_to(:source) }
    it { should respond_to(:icon) }
    it { should respond_to(:type) }
    it { should respond_to(:likes) }
    it { should respond_to(:story) }
    it { should respond_to(:application) }
    it { should respond_to(:created_time) }
    it { should respond_to(:updated_time) }
    it { should respond_to(:shares) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context 'RELATIONS' do
    it { should respond_to(:facebook_page) }
    it { should respond_to(:comments) }
    it { should respond_to(:on) }
  end

  context 'INSTANCE METHODS' do
    describe 'full_fbid' do
      before { FacebookPage.any_instance.stub(:enqueue_facebook_page) }
      let(:page) { FacebookPage.new fb_object_id: 12345 }
      let(:post) do
        post = FacebookPost.new( fb_object_id: 67890)
        post.facebook_page = page
        post
      end

      it 'posts have one underscore' do
        post.full_fbid.should eql('12345_67890')
      end

      it 'comments have two underscores' do
        comment = FacebookPost.new( fb_object_id: 54321 )
        comment.on = post
        comment.full_fbid.should eql('12345_67890_54321')
      end
    end
  end

  context 'CLASS METHODS' do
    describe 'get_new' do
      it 'places the facebook_page in the harvesting queue' do
        FacebookPage.any_instance.stub(:enqueue_facebook_page)
        Resque.should_receive(:enqueue).with(FacebookPost, anything).at_least(5).times
        5.times { |n| FacebookPage.create fb_object_id: n }
        FacebookPost.get_new
      end
    end

    describe 'perform' do
      use_vcr_cassette
      let(:page)     { FacebookPage.create fb_object_id: 175471555835011 }
      let(:old_post) { page.posts.create(fb_object_id: 346871585387899) }

      it 'updates the post when a record already exists and there is updating to be done' do
        old_post.updated_time = DateTime.iso8601('2012-07-25T17:04:09+0000') - 5.days
        old_post.save!
        FacebookPost.perform( page.fb_object_id )
        old_post.message.should be_present
      end

      it 'skips update when the facebook update_time is older than our updated_at' do

      end

      it 'creates new post when a record does not exist'

      it 'creates comments unless they already exist'

      it 'raises a NoFacebookID when on is missing' do
        expect { FacebookPost.perform }.to raise_error(FacebookPage::NoFacebookID)
      end
    end
  end
end

require 'spec_helper'

describe FacebookPost do
  context 'ATTRIBUTES' do
    it { should respond_to(:likes) }
    it { should respond_to(:shares) }
    it { should respond_to(:from) }
    it { should respond_to(:body) }
    it { should respond_to(:fb_created_at) }
    it { should respond_to(:fb_object_id) }
    it { should respond_to(:fb_url) }
  end

  context 'RELATIONS' do
    it { should respond_to(:facebook_page) }
    it { should respond_to(:comments) }
    it { should respond_to(:on) }
  end

  context 'INSTANCE METHODS' do
    describe 'full_fbid' do
      before { FacebookPage.any_instance.stub(:enqueue_facebook_page) }
      let(:page) { FacebookPage.new facebook_id: 12345 }
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
        5.times { |n| FacebookPage.create facebook_id: n }
        FacebookPost.get_new
      end
    end

    describe 'perform' do
      it ''
    end
  end
end

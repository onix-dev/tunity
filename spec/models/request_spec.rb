require 'spec_helper'

describe Request do
  it 'should not allow multiple requests for the same song per user' do
    user = User.make
    id = Sham.youtube_id
    Request.make(:user => user, :youtube_id => id)
    ->{ Request.make(:user => user, :youtube_id => id) }.should raise_error
    Request.make(:user => User.make, :youtube_id => id)
  end

  describe '.next_youtube_id' do
    let(:youtube_id_1) { Sham.youtube_id }
    let(:youtube_id_2) { Sham.youtube_id }
    it 'should get the youtube id with the most users associated with it' do
      Request.make(:user => User.make, :youtube_id => youtube_id_1)
      Request.make(:user => User.make, :youtube_id => youtube_id_1)
      Request.make(:user => User.make, :youtube_id => youtube_id_2)
      Request.next_youtube_id.should == youtube_id_1
    end

    context 'when there is no winner by user count' do
      before do
        now = Time.now
        Request.make(:user => User.make, :youtube_id => youtube_id_1, :created_at => now - 2.days)
        Request.make(:user => User.make, :youtube_id => youtube_id_2, :created_at => now)
      end
      it 'should get the youtube id with the earliest timestamp' do
        Request.next_youtube_id.should == youtube_id_1
      end
    end
  end

  describe '.play_next' do
    let(:next_id) { Sham.youtube_id }

    before do
      stub(Request).next_youtube_id { next_id }
    end

    it 'should add a Play record for the next youtube id' do
      mock(Play).create!(:youtube_id => next_id)
      Request.play_next
    end

    it 'should remove all requests for the next id' do
      Request.make(:user => User.make, :youtube_id => next_id)
      Request.play_next
      Request.where(:youtube_id => next_id).count.should == 0
    end
  end

  describe '.get_next_videos' do
    it 'should return the next some videos' do
      now = Time.now
      requests = [Request.make(:created_at => now - 2),
                  Request.make(:created_at => now - 1),
                  Request.make(:created_at => now)]
      Request.get_next.should == requests
    end

    it 'should return them in the right order when there are multiple for the same ytid' do
      now = Time.now
      youtube_id = Sham.youtube_id
      requests = [Request.make(:created_at => now - 3),
                  Request.make(:created_at => now - 2),
                  Request.make(:created_at => now - 1, :youtube_id => youtube_id)]
      Request.make(:created_at => now, :youtube_id => youtube_id)
      expected_requests = requests[0..1]
      expected_requests.unshift(requests[2])
      Request.get_next.should == expected_requests
    end
  end
end

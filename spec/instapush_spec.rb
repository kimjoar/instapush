require File.join(File.dirname(__FILE__), 'spec_helper')

RSpec::Mocks::setup(RestClient)

describe InstaPush do
  before do
    RestClient.stub!(:post).with("https://www.instapaper.com/api/authenticate", hash_including(:username => 'not_working@gmail.com')).and_raise(RestClient::Forbidden)
    RestClient.stub!(:post).with("https://www.instapaper.com/api/authenticate", hash_including(:username => 'kjbekkelund@gmail.com')).and_return("200")
  end

  describe ".connect" do
    it "should yield an instance of InstaPush if a block is given" do
      yielded = nil
      InstaPush.connect("kjbekkelund@gmail.com") { yielded = self }
      yielded.should be_kind_of(InstaPush)
    end

    it "should return an instance of InstaPush if a block is not given" do
      conn = InstaPush.connect "kjbekkelund@gmail.com"
      conn.should be_kind_of(InstaPush)
    end
  end

  describe ".authenticate" do
    it "should raise an exception when it fails" do
      lambda { InstaPush.authenticate("not_working@gmail.com") }.should raise_error(InstaPush::AuthFailedError)
    end
  end

  describe "#errors" do
    it "should include an error when an api method has failed" do
      InstaPush.connect "not_working@gmail.com" do
        authenticate
        errors.length.should == 1
      end
    end

    it "should include the exception raised" do
      InstaPush.connect "not_working@gmail.com" do
        authenticate
        errors.first.to_s.should == "Forbidden"
      end
    end
  end

  context "a connected user" do
    before do
      @conn = InstaPush.connect "kjbekkelund@gmail.com"
    end

    describe "#authenticate" do
      it "should return a status code of 200 if the authentication is successful" do
        @conn.authenticate.should == "200"
      end

      it "should return false if the authentication was unsuccessful" do
        @conn = InstaPush.connect "not_working@gmail.com"
        @conn.authenticate.should be_false
      end
    end

    describe "#add" do
      it "should post the url to Instapaper" do
        RestClient.should_receive(:post).once.with("https://www.instapaper.com/api/add", hash_including(:url => "http://kimjoar.net"))
        @conn.add "http://kimjoar.net"
      end

      it "should include additional parameters in the call to Instapaper" do
        RestClient.should_receive(:post).once.with("https://www.instapaper.com/api/add", hash_including(:title=>"Kim Joar", :selection=>"description"))
        @conn.add "http://kimjoar.net", :title => "Kim Joar", :selection => "description"
      end

      it "should return a response code of 201 when successful" do
        RestClient.should_receive(:post).once.with("https://www.instapaper.com/api/add", hash_including(:title=>"Kim Joar", :selection=>"description")).and_return("201")
        @conn.add("http://kimjoar.net", :title => "Kim Joar", :selection => "description").should == "201"
      end
    end

    describe "#method_missing" do
      it "should return the extended api url if the input ends with _url" do
        @conn.add_url.should == "https://www.instapaper.com/api/add"
      end

      it "should raise a no method error if the method does not exist and the input does not end with _url" do
        lambda { @conn.method_that_dont_exist }.should raise_error(NoMethodError)
      end
    end
  end
end

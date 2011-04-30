require 'spec_helper'
require 'net/https'

describe Cafe24Sms, ".configuration" do
  it 'should mass assign config value via a block' do
    Cafe24Sms.configure do |config|
      config.user_id = "boribook"
      config.secure_key = "__my_secure_key__"
      config.sender = "011-0000-0000"
    end
    
    Cafe24Sms.user_id.should == "boribook"
    Cafe24Sms.secure_key.should == "__my_secure_key__"
    Cafe24Sms.sender.should == "011-0000-0000"
  end
end

describe Cafe24Sms, ".send" do
  before :each do 
    stub_request(:post, Cafe24Sms::Configuration::SMS_URL)
  end

  it 'should generate form_data' do
    data = Cafe24Sms._form_data(:rphone => "011-9988-4928", :msg => "hello world")
    data[:sms_url].should == Cafe24Sms::Configuration::SMS_URL
    data[:user_id].should == 'boribook'
    data[:secure].should == '__my_secure_key__'
  end

  it "should send_sms" do
    Cafe24Sms.send_sms(:rphone => "011-9988-4928", :msg => "hello world")
    WebMock.should have_requested(:post, Cafe24Sms::Configuration::SMS_URL)
      .with(:body => "sms_url=http%3a%2f%2fsslsms.cafe24.com%2fsms_sender.php&user_id=boribook&secure=__my_secure_key__&sphone1=011&sphone2=0000&sphone3=0000&rphone=011-9988-4928&msg=hello%20world")
  end
end

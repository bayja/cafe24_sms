require 'spec_helper'
require 'net/https'

describe Cafe24Sms, ".configuration" do
  it 'should mass assign config value via a block' do
    Cafe24Sms.configure do |config|
      config.user_id = "boribook"
      config.secure = "__my_secure__"
      config.sphone1 = "011"
      config.sphone2 = "0000"
      config.sphone3 = "0001"
    end
    
    Cafe24Sms.user_id.should == "boribook"
    Cafe24Sms.secure.should == "__my_secure__"
    Cafe24Sms.sphone1.should == "011"
    Cafe24Sms.sphone2.should == "0000"
    Cafe24Sms.sphone3.should == "0001"
  end
end

describe Cafe24Sms, ".send" do
  before :each do 
    stub_request(:post, Cafe24Sms::Configuration::SMS_URL)
    stub_request(:post, Cafe24Sms::Configuration::SMS_REMAIN_URL)
  end

  it 'should generate form_data with essential data' do
    data = Cafe24Sms._form_data(:rphone => "011-9988-4928", :msg => "hello world")

    [:sms_url, :user_id, :secure, :sphone1, :sphone2, :sphone3, :rphone, :msg].each do |key|
      data.keys.include?(key).should be_true
    end

    data[:sms_url].should == Cafe24Sms::Configuration::SMS_URL
    data[:user_id].should == 'boribook'
    data[:secure].should == '__my_secure__'
    data[:sphone1].should == '011'
    data[:sphone2].should == '0000'
    data[:sphone3].should == '0001'
  end

  it "should send_sms" do
    Cafe24Sms.send_sms(:rphone => "011-9988-9988", :msg => "hello world")
    WebMock.should have_requested(:post, Cafe24Sms::Configuration::SMS_URL)
      .with(:body => "sms_url=https%3a%2f%2fsslsms.cafe24.com%2fsms_sender.php&user_id=boribook&secure=__my_secure__&sphone1=011&sphone2=0000&sphone3=0001&rphone=011-9988-9988&msg=hello%20world")
  end
  
  it 'should check remaining sms count' do
    Cafe24Sms.remaining_sms
    WebMock.should have_requested(:post, Cafe24Sms::Configuration::SMS_REMAIN_URL)
      .with(:body => "user_id=boribook&secure=__my_secure__")
  end
end

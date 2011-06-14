module Cafe24Sms
  module Configuration
    SMS_URL = "https://sslsms.cafe24.com/sms_sender.php"
    SMS_REMAIN_URL = "http://sslsms.cafe24.com/sms_remain.php"
    
    attr_accessor :user_id, :secure, :sphone1, :sphone2, :sphone3

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end
  end
end

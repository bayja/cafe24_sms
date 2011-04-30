module Cafe24Sms
  module Configuration
    SMS_URL = "https://sslsms.cafe24.com/sms_sender.php"
    attr_accessor :user_id, :secure_key, :sender

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end
  end
end

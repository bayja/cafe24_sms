require 'net/https'
require 'uri'

module Cafe24Sms
  module SendSms
    def send_sms(options)
      Net::HTTP.post_form(URI.parse(Configuration::SMS_URL), _form_data(options))
    end
    
    def _form_data(options)
      { :sms_url => Configuration::SMS_URL,
        :user_id => self.user_id,
        :secure => self.secure_key,
        :sphone1 => self.sender.split("-")[0],
        :sphone2 => self.sender.split("-")[1],
        :sphone3 => self.sender.split("-")[2]
      }.merge(options)
    end
  end
end

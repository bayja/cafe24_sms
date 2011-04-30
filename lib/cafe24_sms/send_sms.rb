require 'net/https'
require 'uri'

module Cafe24Sms
  module SendSms
    def send_sms(options)
      url = URI.parse(Configuration::SMS_URL)
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data(_form_data(options), '&')

      http_session = Net::HTTP.new(url.host, url.port)
      http_session.use_ssl = true
      http_session.start {|http| http.request(req)}

      # Net::HTTP.post_form(URI.parse(Configuration::SMS_URL), _form_data(options))
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

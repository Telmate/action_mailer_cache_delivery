# I tryed to use Mail::FileDelivery, but it didn't work
#
# CacheDelivery is used to work with email-spec. Put this line in your
# test environment:
# config.action_mailer.delivery_method = :cache
# 
# The code here is borowed from Mail::FileDelivery
#
module Mail
  class CacheDelivery

    def initialize(values)
      self.settings = { :location => './mails' }.merge!(values)
    end

    attr_accessor :settings

    def deliver!(mail)
      File.open(DELIVERIES_CACHE_PATH,'r') do |f|
        deliveries=Marshal.load(f)
      end

      deliveries << mail
      File.open(DELIVERIES_CACHE_PATH,'w') do |f|
        Marshal.dump(deliveries, f)
      end
    end

  end
end

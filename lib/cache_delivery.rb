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

    if RUBY_VERSION >= '1.9.1'
      require 'fileutils'
    else
      require 'ftools'
    end

    def initialize(values)
      self.settings = { :location => './mails' }.merge!(values)
    end

    attr_accessor :settings

    def deliver!(mail)
        
      # Create the cache directory if it doesn't exist
      cache_dir = File.dirname(DELIVERIES_CACHE_PATH)
      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

      if File.exists?(DELIVERIES_CACHE_PATH) == false || File.zero?(DELIVERIES_CACHE_PATH) == true
        deliveries=[]
      else
        File.open(DELIVERIES_CACHE_PATH,'r') do |f|
          deliveries=Marshal.load(f)
        end
      end

      deliveries << mail
      File.open(DELIVERIES_CACHE_PATH,'w') do |f|
        Marshal.dump(deliveries, f)
      end
    end

  end
end

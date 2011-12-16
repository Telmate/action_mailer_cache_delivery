require "action_mailer_cache_delivery/version"
require "action_mailer_cache_delivery/railtie"

module ActionMailerCacheDelivery

  class << self

    attr_reader :deliveries_cache_path
    def install
      @deliveries_cache_path = File.join(Rails.root,'tmp','cache','action_mailer_cache_deliveries.cache')

      require File.join(File.dirname(__FILE__), 'action_mailer_cache_delivery', 'action_mailer', 'base')
      require File.join(File.dirname(__FILE__), 'action_mailer_cache_delivery', 'mail', 'cache_delivery')
      ActionMailer::Base.add_delivery_method :cache, Mail::CacheDelivery

      # Create the cache directory if it doesn't exist
      require 'fileutils'
      cache_dir = File.dirname(deliveries_cache_path)
      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

      # Marshal the empty list of deliveries
      File.open(deliveries_cache_path, 'w') do |f|
        Marshal.dump([], f)
      end
    end
  end

end


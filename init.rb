# Only load this module for the cucumber, selenium and test environments
if Rails.env.cucumber? || Rails.env.selenium? || Rails.env.test?
  ::DELIVERIES_CACHE_PATH = File.join(Rails.root,'tmp','cache','action_mailer_cache_deliveries.cache')

  require File.join(File.dirname(__FILE__), 'lib', 'action_mailer_cache_delivery')
  if Rails::VERSION::MAJOR >= 3
    require File.join(File.dirname(__FILE__), 'lib', 'cache_delivery')
    ActionMailer::Base.add_delivery_method :cache, Mail::CacheDelivery
  end

  # Create the cache directory if it doesn't exist
  require 'fileutils'
  cache_dir = File.dirname(DELIVERIES_CACHE_PATH)
  FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

  # Marshal the empty list of deliveries
  File.open(DELIVERIES_CACHE_PATH, 'w') do |f|
    Marshal.dump([], f)
  end
end

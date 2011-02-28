# Only require this module for the cucumber, selenium and test environments
if ENV['RAILS_ENV'] == 'cucumber' || ENV['RAILS_ENV'] == 'selenium' || ENV['RAILS_ENV'] == 'test'
  require File.join(File.dirname(__FILE__), 'lib', 'action_mailer_cache_delivery')
  if Rails::VERSION::MAJOR >= 3
    require File.join(File.dirname(__FILE__), 'lib', 'cache_delivery')
    ActionMailer::Base.add_delivery_method :cache, Mail::CacheDelivery
  end
end

require 'fileutils'

ActionMailer::Base.class_eval do

  DELIVERIES_CACHE_PATH =
    File.join(RAILS_ROOT,'tmp','cache','action_mailer_cache_deliveries.cache')

  # Deliver +mail+ using the :cache delivery method.
  # This is called by the ActionMailer#deliver! method.
  def perform_delivery_cache(mail)
    deliveries = self.class.cached_deliveries
    deliveries << mail

    # Create the cache directory if it doesn't exist
    cache_dir = File.dirname(DELIVERIES_CACHE_PATH)
    FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

    File.open(DELIVERIES_CACHE_PATH,'w') do |f|
      Marshal.dump(deliveries, f)
    end
  end

  # Return the list of cached deliveries, or an empty list if there are none.
  # This is called by email_spec.
  def self.cached_deliveries
    if File.exists?(DELIVERIES_CACHE_PATH) == false || File.zero?(DELIVERIES_CACHE_PATH) == true
      return []
    else
      File.open(DELIVERIES_CACHE_PATH,'r') do |f|
        Marshal.load(f)
      end
    end
  end

  # Clear the delivery cache of all emails.
  # This is called by email_spec before each scenario.
  def self.clear_cache
    deliveries.clear

    # Create the cache directory if it doesn't exist
    cache_dir = File.dirname(DELIVERIES_CACHE_PATH)
    FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

    # Marshal the empty list of deliveries
    File.open(DELIVERIES_CACHE_PATH, 'w') do |f|
      Marshal.dump(deliveries, f)
    end
  end

end

# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# Initialize the rails application
BifrostBoeger::Application.initialize!

# In tests, then MQ uri will be overridden by the environment variable 'MQ_URI'
if Rails.env.upcase == 'TEST' && !ENV['MQ_URI'].blank?
  MQ_CONFIG['mq_uri'] = ENV['MQ_URI']
  puts "Setting test MQ settings from environment variables: #{MQ_CONFIG.inspect}"
end

include MQService

#This function starts the listener thread which will poll RabbitMQ at regular intervals set by the polling_interval
def start_listener_thread
  polling_interval = MQ_CONFIG['dissemination']['polling_interval_in_minutes']
  t = Thread.new do
    while true
      logger.debug 'Started listener thread...'
      initialize_listener
      logger.debug "Going to sleep for #{polling_interval} minutes..."
      sleep polling_interval.minutes
    end
  end
  #I've read here: https://www.agileplannerapp.com/blog/building-agile-planner/rails-background-jobs-in-threads
  #that each thread started in a Rails app gets its own database connection so when the thread terminates we need
  #to close any database connections too.
  ActiveRecord::Base.connection.close
  #at_exit { t.join }
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      logger.debug "Forked"
      # We’re in a smart spawning mode
      # Now is a good time to connect to RabbitMQ
      start_listener_thread
    end
  end
else
  if Rails.env.upcase != 'TEST'
    start_listener_thread
  end
# We're in direct spawning mode. We don't need to do anything.
end

namespace :bifrost do


  require 'json'
  require 'sendtoqueue'

  desc "Delete all ActiveFedora::Base objects from solr and fedora"
  task :clean => :environment do
    objects = ActiveFedora::Base.all
    objects.each {|af| af.delete }
    puts "#{objects.length} objects deleted from #{Rails.env.titleize} environment"
  end

  desc 'Update index for all objects in Fedora'
  task :reindex => :environment do
    objects = ActiveFedora::Base.all
    objects.each {|af| af.update_index }
    puts "#{objects.length} objects reindexed in #{Rails.env.titleize} environment"
  end

  desc 'Load sample data into Bifrost Boger'
  task :superloader do

    beginning = Time.now

    MQ_CONFIG = YAML.load_file("#{Rails.root}/config/mq_config.yml")[Rails.env]

    puts MQ_CONFIG.inspect

    if MQ_CONFIG['mq_uri'].blank?
      logger.warn 'No dissemination source queue defined '
      return
    end

    puts "using uri #{MQ_CONFIG['_mq_uri']}"

    if MQ_CONFIG['dissemination']['source'].blank?
      logger.warn 'No dissemination source queue defined'
      return
    end

    puts "using destination #{MQ_CONFIG['dissemination']['source']}"

    print "Starting"
    #xml = File.read('../primo_harvest_test_10_records.xml')
    messages = JSON.parse(File.read('dod_samples.json'))

    puts "got #{messages.size} messages"

    messages.each do |msg|
      puts "processing messages #{msg.inspect}"
      puts "Adding #{msg['id']} to queue"
      send_message_to_queue(MQ_CONFIG['uri'],MQ_CONFIG['dissemination']['source'],msg.to_json)
    end

    puts "Time elapsed #{Time.now - beginning} seconds"
  end

end
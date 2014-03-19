# -*- encoding : utf-8 -*-
module MQService
  MQ_CONFIG = YAML.load_file("#{Rails.root}/config/mq_config.yml")[Rails.env]
  require 'e_book_creation_service'
  # Connect to the RabbitMQ broker, and initialize the listeners
  def initialize_listener
    begin
      uri = MQ_CONFIG["mq_uri"]
      logger.debug "Using MQ URI #{uri}"
      conn = Bunny.new(uri)
      conn.start
      ch = conn.create_channel

      logger.debug 'Subscription to MQ successfully started'
      subscribe_to_dod_digitisation(ch)
      logger.debug 'Closing MQ connection...'
      conn.close
      logger.debug 'MQ Connection closed'
    rescue Bunny::TCPConnectionFailed => e
      logger.error 'Connection to RabbitMQ failed'
      logger.error e.to_s
    end
  end

  #Subscribe to the DOD Digitisation Workflow queue
  #@param channel The channel to the message broker.
  def subscribe_to_dod_digitisation(channel)
    if MQ_CONFIG['dissemination']['source'].blank?
      logger.warn 'No dissemination source queue defined -> Not listening'
      return
    end

    source = MQ_CONFIG['dissemination']['source']
    q = channel.queue(source, :durable => true)
    #logger.info "Listening to dissemination source queue: #{source}"

    q.subscribe do |delivery_info, metadata, payload|
      begin
        logger.debug "Received the following DOD eBook message: #{payload}"
        handle_digitisation_dod_ebook(payload)
      rescue => e
        logger.error "Tried to handle DOD eBook message: #{payload}\nCaught error: #{e}"
      end
    end
  end

  #Handles messages about digitised eBooks for the DOD workflow, these messages contain information about the identity
  # of the book in Aleph and where the actual file containing the eBook is stored in KB's digital infrastructure.  If
  # anything is invalid in the message then we just log a warning message as we don't want to interrupt the normal
  # operation of Valhal by raising an error.
  #@param message JSON object read from queue
  #@return book a Book object
  def handle_digitisation_dod_ebook(message)
    if message['UUID'].blank? || message['Dissemination_type'].blank? || message['Type'].nil? || message['MODS'].blank?
      logger.warn "Invalid DOD eBook input message: #{message}"
    end

    e_book_creation_service = EBookCreationService.new
    e_book_creation_service.create_from_message(message)
  end
end

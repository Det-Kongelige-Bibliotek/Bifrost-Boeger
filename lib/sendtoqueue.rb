#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"


def send_message_to_queue(uri,queue,message_payload)

  conn = Bunny.new(uri)
  conn.start

  ch = conn.create_channel
  q = ch.queue(queue, :durable => true)

  options = {
      'content_type' => 'application/json',
      'type' => 'DOD message'
  }

  puts 'Publishing message on queue...'
  q.publish(message_payload, :routing_key => queue, :persistent => true, :timestamp => Time.now.to_i,
            :content_type => options['content_type'], :type => options['type']
  )


  #ch.default_exchange.publish("Hello World From Ruby!", :routing_key => q.name)
  #ch.default_exchange.publish("Hello World From Ruby!")
  puts "Sent '#{message_payload}' on queue '#{queue}'"

  conn.close
end

#send_message_to_queue("Such a great message!")

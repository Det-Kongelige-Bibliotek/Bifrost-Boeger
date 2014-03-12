

require_relative 'sendtoqueue'
require_relative 'parsexml'
require 'json'


# parse a file primo PNX file

beginning = Time.now

print "Starting"
#xml = File.read('../primo_harvest_test_10_records.xml')
xml = File.read('../primo_harvest_6.xml')

doc = REXML::Document.new(xml)


doc.elements.each('sear:SEGMENTS/sear:JAGROOT/sear:RESULT/sear:DOCSET/sear:DOC/PrimoNMBib/record/') do |p|
  record = Hash.new

  puts "Parsing a new record"
  record = make_hash_for_record(p)
  send_message_to_queue(record.to_json)

  puts "Done Parsing a new record"


end

puts "Time elapsed #{Time.now - beginning} seconds"




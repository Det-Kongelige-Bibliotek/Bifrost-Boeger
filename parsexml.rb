require "rexml/document"



# Extracts the field/value elements into a Hash for a book record in Primo XML.
# @param root The root of the 'raw.xml' document where the field/value elements should be extracted into a hash.
def make_hash_for_record(root_record)
  extracted_elements = Hash.new
  root_record.elements.each('control/sourcerecordid') do |control|
    extracted_elements['sourcerecordid'] = control.text

  end


  root_record.elements.each('display') do |displaynode|
    displaynode.each_element_with_text do |displayelement|

      key = displayelement.name
      if extracted_elements.has_key? key
        if extracted_elements[key].is_a?(Array)
          value = extracted_elements[key]
        else
          value = [extracted_elements[key]]
        end
        value << displayelement.text
      else
        value = displayelement.text
      end
      extracted_elements[key] = value
    end
  end

  root_record.elements.each('links/linktorsrc') do |links|
    key = "linktorsrc"
    if extracted_elements.has_key? key
      if extracted_elements[key].is_a?(Array)
        value = extracted_elements[key]
      else
        value = [extracted_elements[key]]
      end
      value << links.text
    else
      value = links.text
    end
    extracted_elements[key] = value

  end

  return extracted_elements
end



# parse a file primo PNX file
print "Starting"
xml = File.read('primo_harvest_test_10_records.xml')

doc = REXML::Document.new(xml)





doc.elements.each('sear:SEGMENTS/sear:JAGROOT/sear:RESULT/sear:DOCSET/sear:DOC/PrimoNMBib/record/') do |p|
  record = Hash.new

  puts "#   Parsing a new record"
  record = make_hash_for_record(p)
  puts record
  puts "#   Done Parsing a new record"


end





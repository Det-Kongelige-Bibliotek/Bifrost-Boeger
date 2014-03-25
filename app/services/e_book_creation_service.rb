class EBookCreationService

  def create_from_message(message_string)
    message_h = JSON.parse(message_string)
    logger.debug message_h.inspect

    logger.debug "creating book from modes #{message_h['MODS']}"
    md = mods_to_hash(message_h['MODS']);
    md['uuid'] = message_h['UUID']
    md['url'] = message_h['Files']

    logger.debug "got hash"
    logger.debug md.inspect
    # check if book exist. retrieve and update it if true
   book = Book.find({uuid: message_h['UUID'] } ).first

    if book.nil?
      book = Book.new(md)
      logger.debug "saving ebook"
      if book.save
        book
      else
        logger.debug "saving ebook failed"
        nil
      end

    else         #Sholud do an update!
      logger.debug "Doing an update of existing ebook"
      book.update(md)
    end
    ## adding CC license
 #   book.add_default_license
 #   book.add_user_to_rights_meta_data_stream

  end


  def mods_to_hash(mods)
    md = {}
    unless mods.blank?
      begin
        logger.debug "parsing mods #{mods.inspect}"
        doc = Nokogiri::XML(mods)
        logger.debug "setting values"
        set_value(md,'barcode',doc.css("mods>identifier[@type='barcode']").text)
        set_value(md,'category',doc.css("mods>genre[@type='Materialetype']"))
        set_value(md,'title',doc.css('mods>titleInfo>title').text)
        set_value(md,'subtitle',doc.css('mods>titleInfo>subTitle').text)
        set_value(md,'titleNonSort',doc.css('mods>titleInfo>nonSort').text)
        set_value(md,'dateIssued',doc.css('mods>originInfo>dateIssued').text)
        set_value(md,'originPlace',doc.css('mods>originInfo>place>placeTerm').text)
        set_value(md,'publisher',doc.css('mods>originInfo>publisher').text)
        set_value(md,'edition',doc.css('mods>originInfo>edition').text)
        set_value(md,'languageISO',doc.css("mods>language>languageTerm[@authority='iso639-2b']").text)
        set_value(md,'languageText',doc.css("mods>language>languageTerm[@authority='text']").text)
        set_value(md,'subjectTopic',doc.css("mods>subject>topic").text)
        set_value(md,'physicalExtent',doc.css("mods>physicalDescription>extent").text)
        set_value(md,'physicalLocation',doc.css("mods>location>physicalLocation").text)

        md['author'] = []
        doc.css('mods>name>namePart').each do |e|
          logger.debug "setting author #{e.text}"
          md['author'] << e.text unless e.text.blank?
        end

        md['description'] = []
        doc.css('mods>note').each {|e| md['description'] << e.text unless e.text.blank?}
      rescue => e
        logger.error "Ebook creation service: Caught error while parsing mods: #{e}"
      end
    end
    md
  end

  def set_value(md,key,val)
    logger.debug "setting value #{key} = #{val}"
    md[key] = val unless val.blank?
  end
  "{\n  \"mods\": {\n    \"xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\",\n    \"xmlns\": \"http://www.loc.gov/mods/v3\",\n    \"version\": \"3.5\",\n    \"xsi:schemaLocation\": \"http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd\",\n    \"identifier\": \"000000001\",\n    \"titleInfo\": {\n      \"nonSort\": \"Den \",\n      \"title\": \"danske Tilskuer\",\n      \"partNumber\": \"No. 78, 89-90, 100-101, 25, 29-30, 47, 94-95\"\n    },\n    \"name\": [\n      {\n        \"type\": \"personal\",\n        \"usage\": \"primary\",\n        \"namePart\": \"Rahbek, K. L.\"\n      },\n      {\n        \"type\": \"personal\",\n        \"namePart\": \"Schiller, Friedrich\"\n      },\n      {\n        \"type\": \"personal\",\n        \"namePart\": \"Oehlenschläger, Adam\"\n      }\n    ],\n    \"typeOfResource\": \"software, multimedia\",\n    \"originInfo\": {\n      \"place\": {\n        \"placeTerm\": \"Kiøbenhavn\"\n      },\n      \"publisher\": \"Johan Frederik Schultz\",\n      \"dateIssued\": \"1800-1801\",\n      \"issuance\": null\n    },\n    \"physicalDescription\": {\n      \"form\": \"electronic\",\n      \"extent\": \"1 bd.\"\n    },\n    \"note\": [\n      \"/ K. L. Rahbek\",\n      \"Hermed indbundet Hymne til Glæden af Schiller ; oversat af A. Oehlenschlæger, med Musik af Kuhlau Kjøbenhavn : C. A. Bording, [efter 1813]. - [8] s.\",\n      \"Hermed indbundet Hymne til Glæden af Schiller ; oversat af A. Oehlenschlæger, med Musik af Kuhlau ; opført første Gang i det harmoniske Selskab den 26 Januarii 1814 Kiøbenhavn : J. Irgens, [1814]. - [8] s.\",\n      \"Hermed indbundet Hymne til Glæden af Schiller ; oversat af A. Oehlenschläger, med Musik af Kuhlau ; afsjungen i det Venskabelige Selskab d. 1ste Januar 1828 Kjøbenhavn : det Poppske Bogtrykkerie, [1828]. - [8] s.\"\n    ],\n    \"location\": [\n      {\n        \"physicalLocation\": \"54,-249 8°\"\n      },\n      {\n        \"url\": \"http://images.kb.dk/bibliotheca_danica/bind%2040141.jpg\"\n      },\n      {\n        \"url\": \"http://example.com/mock-file.pdf\"\n      }\n    ],\n    \"recordInfo\": {\n      \"recordOrigin\": \"Converted from MARCXML to MODS version 3.4 using MARC21slim2MODS3-4.xsl\\n\\t\\t\\t\\t(Revision 1.94 2014/02/21)\"\n    }\n  }\n}"

end

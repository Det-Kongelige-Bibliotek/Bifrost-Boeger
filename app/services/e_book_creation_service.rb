class EBookCreationService

  def create_from_message(message_string)
    message_h = JSON.parse(message_string)
    book = Book.new
    ## adding CC license
    book.add_default_license
    book.add_user_to_rights_meta_data_stream

    book.datastreams['descMetadata'].content = message_h['MODS']
    #begin
      book.uuid = message_h['UUID']
    #rescue SyntaxError => se
    #  print se.backtrace.join("\n")
    #end
    book.url = message_h['files'].values
    if book.save
      book
    else
      nil
    end
  end

end
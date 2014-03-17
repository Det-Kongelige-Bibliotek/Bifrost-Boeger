class EBookCreationService

  def create_from_message(message_string)
    message_h = JSON.parse(message_string)
    book = EBook.new
    book.datastreams['descMetadata'].content = message_h['MODS']
    book.uuid = message_h['UUID']
    book.url = message_h['files'].values
    if book.save
      book
    else
      nil
    end
  end

end
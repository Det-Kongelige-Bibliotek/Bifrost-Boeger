require 'spec_helper'

describe 'MQService' do

  describe 'handle_digitisation_dod_ebook' do

    before (:each) do
      @dod_book_message = File.read("#{Rails.root}/spec/fixtures/valhal_message.json")
    end

    it 'should create a new Book object with a datastream containing valid MODS xml' do

      book = handle_digitisation_dod_ebook(@dod_book_message)
      book.should_not be_nil
      book.datastreams['descMetadata'].should be_kind_of Datastreams::EBookMods
      mods = Nokogiri::XML(book.datastreams['descMetadata'].content.to_s, encoding = 'UTF-8')
      mods.should_not be_nil
      mods_schema = Nokogiri::XML::Schema(File.read("#{Rails.root}/spec/fixtures/mods-3-5.xsd"))
      syntax_errors = mods_schema.validate(mods)
      syntax_errors.each do |error|
        puts error.message
      end
      syntax_errors.should be_empty
    end

  end
end
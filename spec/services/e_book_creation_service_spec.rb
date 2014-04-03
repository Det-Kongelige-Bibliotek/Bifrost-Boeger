require 'spec_helper'

describe 'Create e-book' do


  before(:each) do
    @service = EBookCreationService.new
  end

  it 'should Create an e-book' do
    message = File.read("#{Rails.root}/spec/fixtures/valhal_message.json")
    book = @service.create_from_message(message)
    book.should be_a Book
    book.uuid.should eql '444cd730-3f15-0131-5772-0050562881f4'
    book.urls.should be_a Array
    book.urls.include?('http://www.kb.dk/e-mat/dod/130020709562.pdf').should be_true
  end

  it 'should create an e-book with escaped XML characters in the MODS' do
    message = File.read("#{Rails.root}/spec/fixtures/broken_json.json")
    book = @service.create_from_message(message)
    book.should be_a Book
    Book.find(book.pid).should be_a Book
    book.uuid.should eql '56b9c990-917f-0131-e333-000c29cc78f6'
    book.urls.should be_a Array
    book.urls.include?('http://www.kb.dk/e-mat/dod/130019448607.pdf').should be_true
  end

  it 'should include a sysnumber in the mods' do
    message = File.read("#{Rails.root}/spec/fixtures/valhal_message_with_sys.json")
    book = @service.create_from_message(message)
    book.should be_a Book
    book.recordIdentifier.should be_a String
    book.recordIdentifier.should eql '001467242'
    fed_book = Book.find(book.pid)
    fed_book.recordIdentifier.should eql '001467242'
  end

end
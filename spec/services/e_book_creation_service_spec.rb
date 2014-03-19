require 'spec_helper'

describe 'Create e-book' do


  before(:all) do
    @message = File.read("#{Rails.root}/spec/fixtures/valhal_message.json")
  end

  before(:each) do
    @service = EBookCreationService.new
  end

  it 'should Create an e-book' do
    book = @service.create_from_message(@message)
    book.should be_a Book
    Book.find(book.pid).should be_a Book
    book.uuid.should eql '444cd730-3f15-0131-5772-0050562881f4'
    book.url.should be_a Array
    book.url.include?('http://www.kb.dk/e-mat/dod/130020709562.pdf').should be_true
  end

  it 'should create an e-book with escaped XML characters in the MODS' do
    message = File.read("#{Rails.root}/spec/fixtures/broken_json.json")
    book = @service.create_from_message(message)
    book.should be_a Book
    Book.find(book.pid).should be_a Book
    book.uuid.should eql '56b9c990-917f-0131-e333-000c29cc78f6'
    book.url.should be_a Array
    book.url.include?('http://www.kb.dk/e-mat/dod/130019448607.pdf').should be_true
  end

end
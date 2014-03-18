require 'spec_helper'

describe "books/edit" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :uuid => "MyString",
      :title => "MyString",
      :subtitle => "MyString",
      :publisher => "MyString",
      :originPlace => "MyString",
      :dateIssued => "MyString",
      :languageISO => "MyString",
      :languageText => "MyString",
      :subject => "MyString",
      :physicalExtent => "MyString",
      :physicalLocation => "MyString",
      :url => "MyString",
      :author => "MyString",
      :category => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", book_path(@book), "post" do
      assert_select "input#book_uuid[name=?]", "book[uuid]"
      assert_select "input#book_title[name=?]", "book[title]"
      assert_select "input#book_subtitle[name=?]", "book[subtitle]"
      assert_select "input#book_publisher[name=?]", "book[publisher]"
      assert_select "input#book_originPlace[name=?]", "book[originPlace]"
      assert_select "input#book_dateIssued[name=?]", "book[dateIssued]"
      assert_select "input#book_languageISO[name=?]", "book[languageISO]"
      assert_select "input#book_languageText[name=?]", "book[languageText]"
      assert_select "input#book_subject[name=?]", "book[subject]"
      assert_select "input#book_physicalExtent[name=?]", "book[physicalExtent]"
      assert_select "input#book_physicalLocation[name=?]", "book[physicalLocation]"
      assert_select "input#book_url[name=?]", "book[url]"
      assert_select "input#book_author[name=?]", "book[author]"
      assert_select "input#book_category[name=?]", "book[category]"
      assert_select "textarea#book_description[name=?]", "book[description]"
    end
  end
end

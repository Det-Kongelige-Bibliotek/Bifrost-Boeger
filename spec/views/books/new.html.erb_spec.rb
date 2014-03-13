require 'spec_helper'

describe "books/new" do
  before(:each) do
    assign(:book, stub_model(Book,
      :booktype => "MyString",
      :filetype => "MyString",
      :bookid => "MyString",
      :identifier => "MyString",
      :identifiertype => "MyString",
      :title => "MyString",
      :publicationdate => "MyString",
      :publishername => "MyString",
      :maindescription => "MyString",
      :digitalprotection => "MyString",
      :price => "MyString",
      :contributor_id => "MyString",
      :contributor_content => "MyString",
      :contributorrolecode => "MyString",
      :namesbeforekey => "MyString",
      :keynames => "MyString",
      :contributorrolename => "MyString",
      :numberofpages => "MyString",
      :filesize => "MyString",
      :authors => "MyString",
      :rightlist => "MyString",
      :subjects => "MyString",
      :images => "MyString",
      :authorpid => "MyString"
    ).as_new_record)
  end

  it "renders new book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", books_path, "post" do
      assert_select "input#book_booktype[name=?]", "book[booktype]"
      assert_select "input#book_filetype[name=?]", "book[filetype]"
      assert_select "input#book_bookid[name=?]", "book[bookid]"
      assert_select "input#book_identifier[name=?]", "book[identifier]"
      assert_select "input#book_identifiertype[name=?]", "book[identifiertype]"
      assert_select "input#book_title[name=?]", "book[title]"
      assert_select "input#book_publicationdate[name=?]", "book[publicationdate]"
      assert_select "input#book_publishername[name=?]", "book[publishername]"
      assert_select "input#book_maindescription[name=?]", "book[maindescription]"
      assert_select "input#book_digitalprotection[name=?]", "book[digitalprotection]"
      assert_select "input#book_price[name=?]", "book[price]"
      assert_select "input#book_contributor_id[name=?]", "book[contributor_id]"
      assert_select "input#book_contributor_content[name=?]", "book[contributor_content]"
      assert_select "input#book_contributorrolecode[name=?]", "book[contributorrolecode]"
      assert_select "input#book_namesbeforekey[name=?]", "book[namesbeforekey]"
      assert_select "input#book_keynames[name=?]", "book[keynames]"
      assert_select "input#book_contributorrolename[name=?]", "book[contributorrolename]"
      assert_select "input#book_numberofpages[name=?]", "book[numberofpages]"
      assert_select "input#book_filesize[name=?]", "book[filesize]"
      assert_select "input#book_authors[name=?]", "book[authors]"
      assert_select "input#book_rightlist[name=?]", "book[rightlist]"
      assert_select "input#book_subjects[name=?]", "book[subjects]"
      assert_select "input#book_images[name=?]", "book[images]"
      assert_select "input#book_authorpid[name=?]", "book[authorpid]"
    end
  end
end

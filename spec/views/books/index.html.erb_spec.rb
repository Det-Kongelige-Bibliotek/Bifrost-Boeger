require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
        :booktype => "Booktype",
        :filetype => "Filetype",
        :bookid => "Bookid",
        :identifier => "Identifier",
        :identifiertype => "Identifiertype",
        :title => "Title",
        :publicationdate => "Publicationdate",
        :publishername => "Publishername",
        :maindescription => "Maindescription",
        :digitalprotection => "Digitalprotection",
        :price => "Price",
        :contributor_id => "Contributor",
        :contributor_content => "Contributor Content",
        :contributorrolecode => "Contributorrolecode",
        :namesbeforekey => "Namesbeforekey",
        :keynames => "Keynames",
        :contributorrolename => "Contributorrolename",
        :numberofpages => "Numberofpages",
        :filesize => "Filesize",
        :authors => "Authors",
        :rightlist => "Rightlist",
        :subjects => "Subjects",
        :images => "Images",
        :authorpid => "Authorpid"
      ),
      stub_model(Book,
        :booktype => "Booktype",
        :filetype => "Filetype",
        :bookid => "Bookid",
        :identifier => "Identifier",
        :identifiertype => "Identifiertype",
        :title => "Title",
        :publicationdate => "Publicationdate",
        :publishername => "Publishername",
        :maindescription => "Maindescription",
        :digitalprotection => "Digitalprotection",
        :price => "Price",
        :contributor_id => "Contributor",
        :contributor_content => "Contributor Content",
        :contributorrolecode => "Contributorrolecode",
        :namesbeforekey => "Namesbeforekey",
        :keynames => "Keynames",
        :contributorrolename => "Contributorrolename",
        :numberofpages => "Numberofpages",
        :filesize => "Filesize",
        :authors => "Authors",
        :rightlist => "Rightlist",
        :subjects => "Subjects",
        :images => "Images",
        :authorpid => "Authorpid"
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Booktype".to_s, :count => 2
    assert_select "tr>td", :text => "Filetype".to_s, :count => 2
    assert_select "tr>td", :text => "Bookid".to_s, :count => 2
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Identifiertype".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Publicationdate".to_s, :count => 2
    assert_select "tr>td", :text => "Publishername".to_s, :count => 2
    assert_select "tr>td", :text => "Maindescription".to_s, :count => 2
    assert_select "tr>td", :text => "Digitalprotection".to_s, :count => 2
    assert_select "tr>td", :text => "Price".to_s, :count => 2
    assert_select "tr>td", :text => "Contributor".to_s, :count => 2
    assert_select "tr>td", :text => "Contributor Content".to_s, :count => 2
    assert_select "tr>td", :text => "Contributorrolecode".to_s, :count => 2
    assert_select "tr>td", :text => "Namesbeforekey".to_s, :count => 2
    assert_select "tr>td", :text => "Keynames".to_s, :count => 2
    assert_select "tr>td", :text => "Contributorrolename".to_s, :count => 2
    assert_select "tr>td", :text => "Numberofpages".to_s, :count => 2
    assert_select "tr>td", :text => "Filesize".to_s, :count => 2
    assert_select "tr>td", :text => "Authors".to_s, :count => 2
    assert_select "tr>td", :text => "Rightlist".to_s, :count => 2
    assert_select "tr>td", :text => "Subjects".to_s, :count => 2
    assert_select "tr>td", :text => "Images".to_s, :count => 2
    assert_select "tr>td", :text => "Authorpid".to_s, :count => 2
  end
end

require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Booktype/)
    rendered.should match(/Filetype/)
    rendered.should match(/Bookid/)
    rendered.should match(/Identifier/)
    rendered.should match(/Identifiertype/)
    rendered.should match(/Title/)
    rendered.should match(/Publicationdate/)
    rendered.should match(/Publishername/)
    rendered.should match(/Maindescription/)
    rendered.should match(/Digitalprotection/)
    rendered.should match(/Price/)
    rendered.should match(/Contributor/)
    rendered.should match(/Contributor Content/)
    rendered.should match(/Contributorrolecode/)
    rendered.should match(/Namesbeforekey/)
    rendered.should match(/Keynames/)
    rendered.should match(/Contributorrolename/)
    rendered.should match(/Numberofpages/)
    rendered.should match(/Filesize/)
    rendered.should match(/Authors/)
    rendered.should match(/Rightlist/)
    rendered.should match(/Subjects/)
    rendered.should match(/Images/)
    rendered.should match(/Authorpid/)
  end
end

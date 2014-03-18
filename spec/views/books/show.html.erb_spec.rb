require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :uuid => "Uuid",
      :title => "Title",
      :subtitle => "Subtitle",
      :publisher => "Publisher",
      :originPlace => "Origin Place",
      :dateIssued => "Date Issued",
      :languageISO => "Language Iso",
      :languageText => "Language Text",
      :subject => "Subject",
      :physicalExtent => "Physical Extent",
      :physicalLocation => "Physical Location",
      :url => "Url",
      :author => "Author",
      :category => "Category",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uuid/)
    rendered.should match(/Title/)
    rendered.should match(/Subtitle/)
    rendered.should match(/Publisher/)
    rendered.should match(/Origin Place/)
    rendered.should match(/Date Issued/)
    rendered.should match(/Language Iso/)
    rendered.should match(/Language Text/)
    rendered.should match(/Subject/)
    rendered.should match(/Physical Extent/)
    rendered.should match(/Physical Location/)
    rendered.should match(/Url/)
    rendered.should match(/Author/)
    rendered.should match(/Category/)
    rendered.should match(/MyText/)
  end
end

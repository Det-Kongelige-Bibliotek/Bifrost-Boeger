require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
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
      ),
      stub_model(Book,
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
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uuid".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
    assert_select "tr>td", :text => "Origin Place".to_s, :count => 2
    assert_select "tr>td", :text => "Date Issued".to_s, :count => 2
    assert_select "tr>td", :text => "Language Iso".to_s, :count => 2
    assert_select "tr>td", :text => "Language Text".to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Physical Extent".to_s, :count => 2
    assert_select "tr>td", :text => "Physical Location".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

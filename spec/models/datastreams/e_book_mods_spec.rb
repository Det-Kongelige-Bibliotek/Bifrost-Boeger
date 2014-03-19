require 'spec_helper'

describe Datastreams::EBookMods do

  before(:each) do
    @ebookmods = fixture("aleph0.xml")
    @ds = Datastreams::EBookMods.from_xml(@ebookmods)
  end

  it 'should expose book information' do
    @ds.titleNonSort.should == ['En ']
    @ds.title.should == ['Formiddag hos Frederik den Store']
    @ds.subtitle.should == [': historisk Charakteerbillede']
    @ds.publisher.should == ["Jordans' Forlag"]
    @ds.originPlace.should == ['Kbh']
    @ds.dateIssued.should == ['1859']
    @ds.languageISO.should == []
    @ds.languageText.should == []
    @ds.subjectTopic.should == []
    @ds.physicalExtent.should == ['188 s.']
    @ds.physicalLocation.should == ['57,-458-8°']
    @ds.url.should == ['http://example.com/mock-file.pdf']

    @ds.author.should == ['Mühlbach, Louise']
  end
end
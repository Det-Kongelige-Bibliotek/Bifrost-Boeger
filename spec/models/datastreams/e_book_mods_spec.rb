require 'spec_helper'

describe Datastreams::EBookMods do

  before(:each) do
    @ebookmods = fixture("aleph0.xml")
    @ds = Datastreams::EBookMods.from_xml(@ebookmods)
  end

  it 'should expose book infomation' do
    @ds.mods.titleNonSort.should == ['En ']
    @ds.mods.title.should == ['Formiddag hos Frederik den Store']
    @ds.mods.subTitle.should == [': historisk Charakteerbillede']
    @ds.mods.publisher.should == ["Jordans' Forlag"]
    @ds.mods.originPlace.should == ['Kbh']
    @ds.mods.dateIssued.should == ['1859']
    @ds.mods.languageISO.should == []
    @ds.mods.languageText.should == []
    @ds.mods.subjectTopic.should == []
    @ds.mods.physicalExtent.should == ['188 s.']
    @ds.mods.physicalLocation.should == ['57,-458-8°']
    @ds.mods.url.should == ['http://example.com/mock-file.pdf']
    @ds.mods.author.should == ['Mühlbach, Louise']
  end
end
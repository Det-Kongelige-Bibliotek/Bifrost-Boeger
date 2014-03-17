require 'spec_helper'

describe Datastreams::EBookMods do

  before(:each) do
    @ebookmods = fixture("aleph0.xml")
    @ds = Datastreams::EBookMods.from_xml(@ebookmods)
  end

  it 'should expose book infomation' do
    @ds.mods.title.should == ['En Formiddag hos Frederik den Store, historisk Charakteerbillede']

  end
end
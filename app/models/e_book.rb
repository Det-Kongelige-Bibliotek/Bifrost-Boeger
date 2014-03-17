class EBook < ActiveFedora::Base

  has_metadata :name => 'rightsMetadata', :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => 'descMetadata', :type=>Datastreams::EBookMods

  has_attributes :uuid, :titleNonsort, :title, :subTitle, :publisher, :originPlace, :dateIssued, :languageISO, :languageText,
                :subjectTopic, :physicalExtend, datastream: 'descMetadata', multiple: false

  has_attributes :person, datastream: 'descMetadata', :at => [:name], :multiple => true
  has_attributes :note, datastream: 'descMetadata', :multiple => true

  def get_display_title
    return self.titleNonsort + self.title+", "+self.subTitle
  end
end
class EBook < ActiveFedora::Base

  has_metadata :name => 'rightsMetadata', :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => 'descMetadata', :type=>Datastreams::EBookMods

  has_attributes :uuid, :titleNonSort, :title, :subTitle, :publisher, :originPlace, :dateIssued, :languageISO, :languageText,
                :subjectTopic, :physicalExtent, :physicalLocation,  datastream: 'descMetadata', multiple: false

  has_attributes :person, datastream: 'descMetadata', :at => [:name], :multiple => true
  has_attributes :note, datastream: 'descMetadata', :multiple => true
  has_attributes :url, datastream: 'descMetadata', :multiple => true

  def get_display_title
    return self.titleNonsort + self.title+", "+self.subTitle
  end
end
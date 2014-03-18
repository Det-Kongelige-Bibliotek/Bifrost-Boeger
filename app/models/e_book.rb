class EBook < ActiveFedora::Base

  has_metadata :name => 'rightsMetadata', :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => 'descMetadata', :type=>Datastreams::EBookMods

  has_attributes :uuid, :titleNonSort, :title, :subtitle, :publisher, :originPlace, :dateIssued, :languageISO, :languageText,
                :subjectTopic, :physicalExtent, :physicalLocation,  datastream: 'descMetadata', multiple: false

  has_attributes :person, datastream: 'descMetadata', :at => [:name], :multiple => true
  has_attributes :note, datastream: 'descMetadata', :multiple => true
  has_attributes :url, datastream: 'descMetadata', :multiple => true

  def get_display_title
    if (self.titleNonSort.nil?)
      self.title
    end
    if (self.title.nil?)
      self.titleNonsort
    end
    self.titleNonSort + self.title
  end

  def get display_description

  end


    def to_solr(solr_doc={})
      super
      Solrizer.insert_field(solr_doc,'title', self.get_display_title,:stored_searchable, :displayable, :sortable)
      solr_doc
    end

end

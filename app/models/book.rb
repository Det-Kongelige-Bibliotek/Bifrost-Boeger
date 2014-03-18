class Book  < ActiveFedora::Base


  has_metadata :name => 'rightsMetadata', :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => 'descMetadata', :type=>Datastreams::EBookMods
  #:, :, :, :, :, :, :, :, :subject, :, :, :, :author, :category, :description, :date_start, :date_end
  has_attributes :uuid, :titleNonSort, :title, :subtitle,  :publisher, :originPlace, :dateIssued, :languageISO, :languageText, :subject, :category,
                 :subjectTopic, :physicalExtent, :physicalLocation, :url, datastream: 'descMetadata', multiple: false

  has_attributes :author, datastream: 'descMetadata', :at => [:name], :multiple => true
  has_attributes :description, datastream: 'descMetadata', :multiple => true

  def get_display_title
    if (self.titleNonSort.nil?)
      return self.title
    end
    if (self.title.nil?)
      return self.titleNonsort
    end
    return self.titleNonSort + self.title
  end


  def to_solr(solr_doc = {})
    super
    Solrizer.insert_field(solr_doc,'title',self.get_display_title,:stored_searchable, :displayable)
    solr_doc
  end

end

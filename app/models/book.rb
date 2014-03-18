class Book  < ActiveFedora::Base
  include Hydra::ModelMixins::RightsMetadata

  has_metadata :name => 'rightsMetadata', :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => 'descMetadata', :type=>Datastreams::EBookMods
  #:, :, :, :, :, :, :, :, :subject, :, :, :, :author, :category, :description, :date_start, :date_end
  has_attributes :uuid, :barcode, :titleNonSort, :title, :subtitle,  :publisher, :originPlace, :edition, :dateIssued, :languageISO, :languageText, :subject, :category,
                 :subjectTopic, :physicalExtent, :physicalLocation, :copyright, :url, datastream: 'descMetadata', multiple: false

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
    # The title field contains both of title, subtitle and Non sortable title.
    Solrizer.insert_field(solr_doc,'title',self.get_display_title,:stored_searchable, :displayable)


    Solrizer.insert_field(solr_doc, 'licens', self.license_url, :stored_searchable, :displayable, :facetable)
    Solrizer.insert_field(solr_doc, 'licens_url', self.license_url, :stored_searchable, :displayable, :facetable)
    Solrizer.insert_field(solr_doc, 'licens_title', self.license_title, :stored_searchable, :displayable, :facetable)
    Solrizer.insert_field(solr_doc, 'licens_description', self.license_description, :stored_searchable, :displayable)

    solr_doc
  end

  delegate :license_title, :to=>'rightsMetadata', :at=>[:license, :title], :index_as=>[:stored_searchable, :displayable, :sortable], :unique=>true
  delegate :license_description, :to=>'rightsMetadata', :at=>[:license, :description], :unique=>true
  delegate :license_url, :to=>'rightsMetadata', :at=>[:license, :url], :unique=>true

  delegate :read_access_human_text, :to=>'rightsMetadata', :at=>[:read_access, :human_readable] , :unique=>true
  delegate :discover_access_human_text, :to=>'rightsMetadata', :at=>[:discover_access, :human_readable] , :unique=>true
  delegate :edit_access_human_text, :to=>'rightsMetadata', :at=>[:edit_access, :human_readable] , :unique=>true





  def add_default_license
    self.license_title = 'Navngivelse-IkkeKommerciel-IngenBearbejdelse 3.0 Unported (CC BY-NC-ND 3.0)'
    self.license_url = 'http://creativecommons.org/licenses/by-nc-nd/3.0/deed.da'
    self.license_description = '<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/deed.da"><img alt="Creative Commons licens" src="http://i.creativecommons.org/l/by-nc-nd/3.0/80x15.png"/></a>'
  end

  def add_user_to_rights_meta_data_stream
    self.edit_access_human_text = "Administrators can edit this object"
    #self.rightsMetadata.update_permissions({ "person"=>{pid=>"edit"}})
    self.rightsMetadata.update_permissions({"group"=>{"public"=>"read","admin"=>"edit"}})
  end

end

class Book  < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include Hydra::Collections::Collectible


  has_metadata :name => 'descMetadata', :type=>Datastreams::EBookMods
  #:, :, :, :, :, :, :, :, :subject, :, :, :, :author, :category, :description, :date_start, :date_end
  has_attributes :uuid, :barcode, :titleNonSort, :title, :subtitle,  :publisher, :originPlace, :edition, :dateIssued, :languageText, :subject, :category,
                 :subjectTopic, :physicalExtent, :physicalLocation, :recordIdentifier, datastream: 'descMetadata', multiple: false

  has_attributes :languageISO, datastream: 'descMetadata', :multiple => true
  has_attributes :author, datastream: 'descMetadata', :multiple => true
  has_attributes :description, datastream: 'descMetadata', :multiple => true
  has_attributes :urls, datastream: 'descMetadata', :multiple => true

  def get_display_title
    if (self.titleNonSort.nil?)
      return self.title
    end
    if (self.title.nil?)
      return self.titleNonsort
    end
    return self.titleNonSort + self.title
  end

  def author(*arg)
    self.descMetadata.get_authors
  end

  def author=(val)
    self.descMetadata.remove_authors
    val.each do |v|
      unless v.blank?
        self.descMetadata.insert_author(v)
      end
    end
  end

  def languageISO
    self.descMetadata.get_languageISO
  end

  def languageISO=(val)
    self.descMetadata.remove_languageISO
    val.each do |v|
      unless v.blank?
        self.descMetadata.insert_languageISO(v)
      end
    end
  end

  def to_solr(solr_doc = {})
    super
    # The title field contains both of title, subtitle and Non sortable title.
    Solrizer.insert_field(solr_doc,'title',self.get_display_title,:stored_searchable, :displayable)
    Solrizer.insert_field(solr_doc,'title_sort',self.title,:sortable)
    Solrizer.insert_field(solr_doc,'author_sort',self.author.join(' '),:sortable)

    unless self.author.nil?
      self.author.each do |a|
        Solrizer.insert_field(solr_doc,'author',a,:stored_searchable,:facetable)
      end
    end

    unless self.languageISO.nil?
      self.languageISO.each do |lang|
        Solrizer.insert_field(solr_doc, 'languageISO', lang, :stored_searchable, :facetable)
      end
    end
    index_collection_pids(solr_doc)
    solr_doc
  end




  def add_default_license
    self.license_title = 'Navngivelse-IkkeKommerciel-IngenBearbejdelse 3.0 Unported (CC BY-NC-ND 3.0)'
    self.license_url = 'http://creativecommons.org/licenses/by-nc-nd/3.0/deed.da'
    self.license_description = '<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/deed.da"><img alt="Creative Commons licens" src="http://i.creativecommons.org/l/by-nc-nd/3.0/80x15.png"/></a>'
  end

  def add_user_to_rights_meta_data_stream
    #self.edit_access_human_text = "Administrators can edit this object"
    #self.rightsMetadata.update_permissions({ "person"=>{pid=>"edit"}})
    self.set_read_groups( ["public"], [])
    #self.set_discover_groups( ["public"], [])
    self.set_edit_groups( ["admin"], [])
    #self.rightsMetadata.update_permissions({"group"=>{"public"=>"edit","public"=>"read","admin"=>"edit"}})
  end

end

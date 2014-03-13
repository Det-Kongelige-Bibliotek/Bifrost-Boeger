class BookSimpleMetaDatastream < ActiveFedora::OmDatastream
  # a datastream storing data for both DOD books and onix.

    set_terminology do |t|
      t.root(path: 'fields')
      t.title(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'title', :label=>'Title') #onix
      t.author(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>'author', :label=>'Author') #onix
      t.person(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>'person', :label=>'Person')
      t.category(:type => :text, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>'category', :label=>'Category')
      t.genre(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>'genre', :label=>'Genre')
      t.copyright(:type => :string, :index_as => [:stored_searchable, :displayable, :sortable, :facetable], :path => 'copyright', :label => 'Copyright')
      t.date_start(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable],:path=>'date_start', :label=>'date_start')
      t.date_end
      t.date_txt(:type => :string, :index_as=>[:stored_searchable, :displayable, :facetable],:path=>'date_txt', :label=>'date_txt')
      t.description(:type => :string, :index_as=>[:stored_searchable, :displayable],:path=>'description', :label=>'Description')
      t.lcsh(:type => :string, :index_as=>[:stored_searchable, :displayable],:path=>'lcsh', :label=>'lcsh')
      t.fileidentifier(:type => :string, :index_as=>[:stored_searchable, :displayable],:path=>'fileidentifier', :label=>'Fileidentifier')
      t.geo_lat
      t.geo_lng
      t.keywords(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>{:attribute=>'keywords'}, :label=>'keywords')
      #      :subjects,

      t.type(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>{:attribute=>'Type'}, :label=>'Type')
      t.dimensions(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable, :facetable],:path=>{:attribute=>'dimensions'}, :label=>'dimensions')
      t.local(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable,  :facetable],:path=>'local', :label=>'Lokal')
      t.path_to_image(:type => :string, :index_as=>[:stored_searchable, :displayable],:path=>'pathtoimage', :label=>'pathtoimage')
      t.opstilling(:type => :string, :index_as=>[:stored_searchable, :displayable],:path=>'opstilling', :label=>'opstilling')
      t.cumulusuuid(:type=>:string, :index_as=> :stored_searchable)


      #Onix specific

      t.identifier(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'identifier', :label=>'identifier') #oni
      t.identifiertype(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'identifiertype', :label=>'identifiertype') #oni
      t.images(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'images', :label=>'images') #oni
      t.keynames(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'keynames', :label=>'keynames') #oni
      t.maindescription(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'maindescription', :label=>'maindescription') #oni
      t.namesbeforekey(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'namesbeforekey', :label=>'namesbeforekey') #oni
      t.numberofpages(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'numberofpages', :label=>'numberofpages') #oni

      t.publicationdate(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'publicationdate', :label=>'publicationdate') #oni
      t.publishername(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'publishername', :label=>'publishername') #oni
      t.rightlist(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'rightlist', :label=>'rightlist') #oni
      t.subjects(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'subjects', :label=>'subjects') #oni


      t.authorpid(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'authorpid', :label=>'authorpid') #oni

      t.bookid(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'bookid', :label=>'bookid') #oni
      t.booktype(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'booktype', :label=>'booktype') #oni
      t.filetype(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'filetype', :label=>'filetype') #oni
      t.filesize(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'filesize', :label=>'filesize') #oni
      t.contributor_content(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'contributor_content', :label=>'contributor_content') #oni
      t.contributor_id(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'contributor_id', :label=>'contributor_id') #oni
      t.contributorrolecode(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'contributorrolecode', :label=>'contributorrolecode') #oni
      t.contributorrolename(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'contributorrolename', :label=>'contributorrolename') #oni
      t.creationdate(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'creationdate', :label=>'creationdate') #oni
      t.digitalprotection(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'digitalprotection', :label=>'digitalprotection') #oni
      t.price(:type => :string, :index_as=>[:stored_searchable, :displayable, :sortable],:path=>'price', :label=>'price') #onix
    end

    def self.xml_template
      Nokogiri::XML.parse('<fields/>')
    end
end

# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  # These before_filters apply the hydra access controls

  # before_filter :enforce_show_permissions, :only=>:show

  # This applies appropriate access controls to all solr queries
  # CatalogController.solr_search_params_logic += [:add_access_controls_to_solr_params]


  # This filters out objects that you want to exclude from search results, like FileAssets
  CatalogController.solr_search_params_logic += [:exclude_unwanted_models]


  configure_blacklight do |config|
    config.default_solr_params = {
        :qf => 'title_tesim title_ssm author_tesim description_tesim uuid_tesim local_tesim imagetype_tesim category_tesim fileidentifier_tesim keywords_tesim id copyright_tesim dateIssued_sim',
        :qt => 'search',
        :fq => 'active_fedora_model_ssi:Book',
        :rows => 10
    }

    # solr field configuration for search results/index views
    config.index.show_link = 'title_ssm'
    config.index.record_tsim_type = 'has_model_ssim'

    # solr field configuration for document/show views
    config.show.html_title = 'title_ssm'
    config.show.heading = 'title_ssm'
    config.show.display_type = 'has_model_ssim'
    config.show.subtitle = 'subtitle_tesim'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _tsimed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    config.add_facet_field solr_name('author', :facetable), :label => 'Forfatter'
    config.add_facet_field solr_name('languageISO', :facetable), :label => 'Sprog', :helper_method => :translate_lang_code
    config.add_facet_field solr_name('dateIssued', :facetable), :label => 'Udgivelsesår'
    #config.add_facet_field solr_name('object_type', :facetable), :label => 'Format'
    #config.add_facet_field solr_name('pub_date', :facetable), :label => 'Publication Year'
    #config.add_facet_field solr_name('subject_topic', :facetable), :label => 'Topic', :limit => 20
    #config.add_facet_field solr_name('language', :facetable), :label => 'Language', :limit => true
    #config.add_facet_field solr_name('lc1_letter', :facetable), :label => 'Call Number'
    #config.add_facet_field solr_name('subject_geo', :facetable), :label => 'Region'
    #config.add_facet_field solr_name('subject_era', :facetable), :label => 'Era'

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys
    #use this instead if you don't want to query facets marked :show=>false
    #config.default_solr_params[:'facet.field'] = config.facet_fields.select{ |k, v| v[:show] != false}.keys


    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name('author', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.author')
    config.add_index_field solr_name('person', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.person')
    config.add_index_field solr_name('fileidentifier', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.fileidentifier')
    config.add_index_field solr_name('category', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.category')
    config.add_index_field solr_name('genre', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.genre')
    config.add_index_field solr_name('local', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.area')
    #config.add_index_field solr_name('description', :stored_searchable, type: :string), :label => 'kb.search.index.description'
    config.add_index_field solr_name('imagetype', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.type')
    config.add_index_field solr_name('copyright', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.license')
    config.add_index_field solr_name('dateIssued', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.date_issued')

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    #config.add_show_field solr_name('title', :stored_searchable, type: :string), :label => 'kb.show.title'
    #config.add_show_field solr_name('subtitle', :stored_searchable, type: :string), :label => 'kb.show.subtitle'
    config.add_show_field solr_name('author', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.author'), :link_to_search => :author_sim
    config.add_show_field solr_name('edition', :displayable, type: :string), :label => I18n.t('kb.search.index.edition')
    config.add_show_field solr_name('subjectTopic', :stored_searchable, type: :string), :label => I18n.t('kb.show.subject')
    config.add_show_field solr_name('dateIssued', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.date_issued')
    config.add_show_field solr_name('description', :stored_searchable, type: :string), :label => I18n.t('kb.search.index.description')
    config.add_show_field solr_name('languageISO', :stored_searchable, type: :string), :label => I18n.t('kb.show.language'), :helper_method => :translate_value
    config.add_show_field solr_name('recordIdentifier', :displayable), :label => I18n.t('kb.show.physical_version'), :helper_method => :create_rex_physical_book_search_link
    config.add_show_field solr_name('urls', :displayable), :label => 'PDF', :label => I18n.t('kb.show.download'), :helper_method => :create_download_link
    #config.add_show_field solr_name('barcode', :displayable, type: :string), :label => 'Barcode'
    #config.add_show_field solr_name('title_vern', :stored_searchable, type: :string), :label => 'Title:'
    #config.add_show_field solr_name('subtitle', :stored_searchable, type: :string), :label => 'Subtitle:'
    #config.add_show_field solr_name('subtitle_vern', :stored_searchable, type: :string), :label => 'Subtitle:'
    #config.add_show_field solr_name('author', :stored_searchable, type: :string), :label => 'Author:'
    #config.add_show_field solr_name('author_vern', :stored_searchable, type: :string), :label => 'Author:'
    #config.add_show_field solr_name('format', :symbol), :label => 'Format:'
    #config.add_show_field solr_name('url_fulltext_tsim', :stored_searchable, type: :string), :label => 'URL:'
    #config.add_show_field solr_name('url_suppl_tsim', :stored_searchable, type: :string), :label => 'More Information:'
    #config.add_show_field solr_name('language', :stored_searchable, type: :string), :label => 'Language:'
    #config.add_show_field solr_name('published', :stored_searchable, type: :string), :label => 'Published:'
    #config.add_show_field solr_name('published_vern', :stored_searchable, type: :string), :label => 'Published:'
    #config.add_show_field solr_name('lc_callnum', :stored_searchable, type: :string), :label => 'Call number:'
    #config.add_show_field solr_name('isbn', :stored_searchable, type: :string), :label => 'ISBN:'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', :label => 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('title') do |field|
      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = {
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end

    config.add_search_field('author') do |field|
      field.solr_local_parameters = {
        :qf => '$author_qf',
        :pf => '$author_pf'
      }
    end

    config.add_search_field('dateIssued') do |field|
      field.solr_local_parameters = {
        :qf => '$dateIssued_qf',
        :pf => '$dateIssued_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, dateIssued_si desc, title_sort_si asc', :label => I18n.t('kb.search.sort.relevance')
    config.add_sort_field 'dateIssued_si desc, title_sort_si asc', :label => I18n.t('kb.search.sort.date_issued')
    config.add_sort_field 'author_sort_si asc, title_sort_si asc', :label => I18n.t('kb.search.sort.author')
    config.add_sort_field 'title_sort_si asc, dateIssued_si desc', :label => I18n.t('kb.search.sort.title')

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end



end

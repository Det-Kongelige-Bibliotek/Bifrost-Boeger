#Extending the default Blacklight CatalogHelper and adding some extra functionality
module CatalogHelper
  #Don't remove this, when we over-ride Blacklights CatalogHelper we need to include all its behaviour manually
  # otherwise the default Blacklight behaviour goes missing
  include Blacklight::CatalogHelperBehavior
  REX_CONFIG = YAML.load_file("#{Rails.root}/config/rex.yml")[Rails.env]

  # Function to create a REX search link for the digital book using the Aleph SYS num
  # Called as helper in catalog controller for recordIdentifier_ssm field
  # @param [Hash] args { :field => fieldName, :document => SolrDoc }
  # @return [String] URL for REX book search
  def create_rex_physical_book_search_link(args)
    document = args[:document]
    field = args[:field]
    sys_num = document[field].first
    unless sys_num.nil?
      rex_link = REX_CONFIG['rex_book_search_template_uri'].gsub('SYS_NUM', "KGL01#{sys_num}")
      link_to(t('kb.show.find_in_rex'), rex_link)
    end
  end

  # given a hash of search_fields, render a ul with search fields
  # as list elements within links
  def render_search_dropdown(search_fields)
    content_tag(:ul, class: 'dropdown-menu', id: 'js_search_type') do
      search_fields.each do |key, value|
        # FIXME: It sould not be necessary to camelcase anything here, since the fieldname is all_fields and date_issued - but somewhere the keys gets translated/labeled
        key = key.gsub(/\s+/, "").camelize(:lower) # FIXME: This is part of the uneven translation thing we need to look into
        concat(content_tag(:li,  content_tag(:a, t('kb.search.limit.' + key), {href: '#'}), {id: value}))
      end
    end
  end

  def render_bifrost_header

    title = @document['title_tesim'].to_sentence.html_safe if @document['title_tesim']
    titleExtended = @document['titleExtended_tesim'].to_sentence.html_safe if @document['titleExtended_tesim']
    subtitle = @document['subtitle_tesim'].to_sentence.html_safe if @document['subtitle_tesim']
    # cut off any initial ": " if it is present. FIXME: This shouldn't be done here, but in Sigges script - it is here now solely for the presentation @ Easter
    subtitle = subtitle.gsub(/^:\s(.*)/, '\1') if @document['subtitle_tesim']

    if title and titleExtended and subtitle
      content_tag(:h1, title + titleExtended) + content_tag(:h2, subtitle)
    elsif title and titleExtended
      content_tag(:h1, title + titleExtended)
    elsif title and subtitle
      content_tag(:h1, title) + content_tag(:h2, subtitle)
    elsif titleExtended and subtitle
      content_tag(:h1, titleExtended) + content_tag(:h2, subtitle)
    elsif title
      content_tag(:h1, title)
    elsif titleExtended
      content_tag(:h1, titleExtended)
    elsif subtitle
      content_tag(:h2, subtitle)
    end

  end

  ##
  # Render the download pdf links
  # @options
  def render_download_links(title = nil, link = nil, type = 'pdf')
    ("<a href='#{link} '>" + image_tag("icon_" + type + ".png", class: 'thumb') + " #{title}</a>").html_safe
  end

  # Helper method called from CatalogController
  # when we need to translate a field's value
  # e.g. codes to proper names (dan -> Dansk | Danish)
  def translate_value(args)
    document = args[:document]
    field = args[:field]
    translate_lang_code(document[field].first)
  end

  # Helper method to translate language code
  # to a proper name (e.g. dan -> Dansk)
  # Called from CatalogController languageISO facet
  def translate_lang_code(val)
    t(val.upcase)
  end

end
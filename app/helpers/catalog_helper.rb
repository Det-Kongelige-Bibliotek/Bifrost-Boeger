#Extending the default Blacklight CatalogHelper and adding some extra functionality
module CatalogHelper
  #Don't remove this, when we over-ride Blacklights CatalogHelper we need to include all its behaviour manually
  # otherwise the default Blacklight behaviour goes missing
  include Blacklight::CatalogHelperBehavior

  REX_CONFIG = YAML.load_file("#{Rails.root}/config/rex.yml")[Rails.env]
  METADATA_CONFIG = YAML.load_file("#{Rails.root}/config/metadata.yml")

  #Function to create a REX search link for the digital book using the Aleph SYS num
  # @param [String] sys_num
  # @return [String] URL for REX book search
  def create_rex_physical_book_search_link(sys_num)
    REX_CONFIG['rex_book_search_template_uri'].gsub('SYS_NUM', "KGL01#{sys_num.to_sentence.html_safe}")
  end

  # this helper function allows us to configure the metadata display
  # via a YAML file consisting of key (field label), value (solr field name)
  # @return [String] dl consisting of metadata labels and values
  def render_document_metadata
    content_tag(:dl, class: 'dl-horizontal dl-invert') do
      METADATA_CONFIG.each_pair do |key, value|
        unless @document[value].nil? || @document[value].empty?
          concat(content_tag(:dt, class: "blacklight-show-#{key}") { t key})
          concat(content_tag(:dd) { @document[value].to_sentence.html_safe })
        end
      end
    end
  end

  # given a hash of search_fields, render a ul with search fields
  # as list elements within links
  def render_search_dropdown(search_fields)
    content_tag(:ul, class: 'dropdown-menu', id: 'js_search_type') do
      search_fields.each do |key, value|
        concat(content_tag(:li,  content_tag(:a, key, {href: '#'}), {id: value}))
      end
    end
  end

  def render_bifrost_header

    title = @document['title_tesim'].to_sentence.html_safe if @document['title_tesim']
    titleExtended = @document['titleExtended_tesim'].to_sentence.html_safe if @document['titleExtended_tesim']
    subtitle = @document['subtitle_tesim'].to_sentence.html_safe if @document['subtitle_tesim']

    if title and titleExtended and subtitle
      content_tag(:h1, title) + content_tag(:h2, titleExtended) + content_tag(:h3, subtitle)
    elsif title and titleExtended
      content_tag(:h1, title) + content_tag(:h2, titleExtended)
    elsif title and subtitle
      content_tag(:h1, title) + content_tag(:h3, subtitle)
    elsif titleExtended and subtitle
      content_tag(:h1, titleExtended) + content_tag(:h3, subtitle)
    elsif title
      content_tag(:h1, title)
    elsif titleExtended
      content_tag(:h2, titleExtended)
    elsif subtitle
      content_tag(:h3, subtitle)
    end

  end
end
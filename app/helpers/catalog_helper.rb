#Extending the default Blacklight CatalogHelper and adding some extra functionality
module CatalogHelper
  #Don't remove this, when we over-ride Blacklights CatalogHelper we need to include all its behaviour manually
  # otherwise the default Blacklight behaviour goes missing
  include Blacklight::CatalogHelperBehavior

  REX_CONFIG = YAML.load_file("#{Rails.root}/config/rex.yml")[Rails.env]

  #Function to create a REX search link for the digital book using the barcode
  # @param [String] barcode
  # @return [String] URL for REX book search
  def create_rex_physical_book_search_link(barcode)
    REX_CONFIG['rex_book_search_template_uri'].gsub('BARCODE', barcode.to_sentence.html_safe)
  end
end
namespace :sifd do
  desc "Delete all ActiveFedora::Base objects from solr and fedora"
  task :clean => :environment do
    objects = ActiveFedora::Base.all
    objects.each {|af| af.delete }
    puts "#{objects.length} objects deleted from #{Rails.env.titleize} environment"
  end
  desc "Add FITS file characterization datastream to all SIFD BasicFile objects that don't have it"

end
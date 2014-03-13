class EBook < ActiveFedora::Base

  has_metadata :name => 'rightsMetadata', :type => Hydra::Datastream::RightsMetadata
  has_metadata :name => 'descMetadata', :type=>Datastreams::WorkMods

  has_attributes :title, datastream 'descMetadata', :multible => false


end
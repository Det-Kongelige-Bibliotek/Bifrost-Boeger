class Book < ActiveFedora::Base
  attr_accessor  :uuid, :uuid_cumulus, :title, :author, :description, :editor, :created_at, :update_at
  attr_accessor :authorpid,  :bookid, :booktype, :contributor_content, :contributor_id, :contributorrolecode, :contributorrolename, :creationdate, :digitalprotection, :filesize, :filetype, :identifier, :identifiertype, :images, :keynames, :maindescription, :namesbeforekey, :numberofpages, :price, :publicationdate, :publishername, :rightlist, :subjects, :title
end

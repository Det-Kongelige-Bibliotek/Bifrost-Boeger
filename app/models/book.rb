class Book < ActiveRecord::Base
  attr_accessible :authorpid, :authors, :bookid, :booktype, :contributor_content, :contributor_id, :contributorrolecode, :contributorrolename, :creationdate, :digitalprotection, :filesize, :filetype, :identifier, :identifiertype, :images, :keynames, :maindescription, :namesbeforekey, :numberofpages, :price, :publicationdate, :publishername, :rightlist, :subjects, :title
end

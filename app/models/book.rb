class Book < ActiveFedora::Base
 has_attributes :authorpid, :authors, :bookid, :booktype, :contributor_content, :contributor_id, :contributorrolecode, :contributorrolename, :creationdate, :digitalprotection, :filesize, :filetype, :identifier, :identifiertype, :images, :keynames, :maindescription, :namesbeforekey, :numberofpages, :price, :publicationdate, :publishername, :rightlist, :subjects, :title
end

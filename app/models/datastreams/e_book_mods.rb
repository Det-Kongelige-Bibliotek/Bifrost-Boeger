module Datastreams
  class EBookMods  < ActiveFedora::OmDatastream
    set_terminology do |t|
      t.root(:path=>'mods', :xmlns=>"http://www.loc.gov/mods/v3")
      t.uuid(:path=>"identifier[@type='uri']")
      t.genre(:path=>"genre")

      t.typeOfResource()
      t.location do
        t.physicalLocation()
        t.url()
      end
      t.titleInfo do
        t.nonSort()
        t.title()
        t.subTitle()
      end

      t.originInfo do
        t.publisher()
        t.place do
          t.placeTerm()
        end
        t.dateIssued()
      end

      t.language do
        t.languageISO(:path=>"languageTerm[@authority='iso639-2b']")
        t.languageText(:path=>"languageTerm[@type='text']")
      end

      t.subject(:path=>"subject[@authority='lcsh']") do
        t.topic()
      end
      t.physicalDescription do
        t.extent()
      end
      t.name do
        t.namePart()
      end

      t.note()


      t.titleNonSort(:proxy => [:titleInfo, :nonSort])
      t.title(:proxy => [:titleInfo, :title])
      t.subtitle(:proxy => [:titleInfo, :subTitle])
      t.category(:proxy => [:genre], :index_as=>[:stored_searchable, :facetable])
      t.publisher(:proxy => [:originInfo, :publisher],:index_as=>[:stored_searchable, :facetable])
      t.originPlace(:proxy => [:originInfo, :place, :placeTerm],:index_as=>[:stored_searchable, :facetable])
      t.dateIssued(:proxy => [:originInfo, :dateIssued],:index_as=>[:stored_searchable, :facetable])
      t.languageISO(:proxy => [:language, :languageISO],:index_as=>[:stored_searchable, :facetable])
      t.languageText(:proxy => [:language, :languageText],:index_as=>[:stored_searchable, :facetable])
      #t.topic(:proxy => [:subject, :topic])
      t.subjectTopic(:proxy => [:subject, :topic],:index_as=>[:stored_searchable, :facetable])
      t.physicalExtent(:proxy => [:physicalDescription, :extent])
      t.physicalLocation(:proxy => [:location, :physicalLocation])
      t.url(:proxy => [:location, :url])
      t.author(:proxy => [:name, :namePart])
      t.description(:proxy => [:note],:index_as=>[:stored_searchable])


    end

    def self.xml_template
      Nokogiri::XML.parse '<mods:mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org.1999/xlink" version="3.4" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd" xmlns:mods="http://www.loc.gov/mods/v3">
        <mods:genre type="Materialetype"/>
        <mods:identifier type="uri"/>
        <mods:location>
          <mods:url/>
          <mods:shelfLocator/>
        </mods:location>
        <mods:recordInfo>
          <mods:recordContentSource/>
          <mods:recordOrigin/>
          <mods:recordCreationDate encoding="w3cdtf"/>
          <mods:recordChangeDate encoding="w3cdtf"/>
          <mods:recordIdentifier/>
          <mods:languageOfCataloging>
            <mods:languageTerm authority="iso639-2b" type="code"/>
          </mods:languageOfCataloging>
        </mods:recordInfo>
        <mods:relatedItem type="otherFormat">
          <mods:identifier displayLabel="image" type="uri"/>
        </mods:relatedItem>
        <mods:titleInfo>
          <mods:title/>
          <mods:subTitle/>
        </mods:titleInfo>
        <mods:originInfo>
          <mods:place>
            <mods:placeTerm type="text"/>
          </mods:place>
          <mods:publisher></mods:publisher>
          <mods:dateIssued keyDate="yes" encoding="w3cdtf"/>
        </mods:originInfo>
        <mods:language>
            <mods:languageTerm authority="iso639-2b"></mods:languageTerm>
            <mods:languageTerm type="text"></mods:languageTerm>
        </mods:language>
        <mods:subject authority="lcsh">
          <mods:topic/>
        </mods:subject>
        <mods:physicalDescription>
          <mods:extent/>
        </mods:physicalDescription>
        <mods:typeOfResource/>
        <mods:name>
            <mods:namePart/>
        </mods:name>
        <mods:note></mods:note>
      </mods:mods>'
    end
  end
end
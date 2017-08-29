# frozen_string_literal: true
class Page < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :id, Valkyrie::Types::ID.optional
  attribute :title, Valkyrie::Types::Set
  attribute :viewing_hint, Valkyrie::Types::Set
  attribute :cornell_id, Valkyrie::Types::SingleValuedString
  attribute :heading, Valkyrie::Types::Set 
  attribute :node, Valkyrie::Types::Set 
  attribute :node_type, Valkyrie::Types::Set 
  attribute :page_number, Valkyrie::Types::Set 
  attribute :label, Valkyrie::Types::Set 
  attribute :relative_path, Valkyrie::Types::Set 
  attribute :import_url,Valkyrie::Types::Set 
  attribute :resource_type, Valkyrie::Types::Set 
  attribute :creator, Valkyrie::Types::Set 
  attribute :contributor, Valkyrie::Types::Set 
  attribute :contributor_URI, Valkyrie::Types::Set 
  attribute :creator_URI, Valkyrie::Types::Set 
  attribute :note, Valkyrie::Types::Set 
  attribute :abstract, Valkyrie::Types::Set 
  attribute :publisher, Valkyrie::Types::Set 
  attribute :publisher_URI, Valkyrie::Types::Set 
  attribute :date_created, Valkyrie::Types::Set 
  attribute :language_URI, Valkyrie::Types::Set 
  attribute :language, Valkyrie::Types::Set 
  attribute :identifier, Valkyrie::Types::Set 
  attribute :based_near, Valkyrie::Types::Set 
  attribute :related_url, Valkyrie::Types::Set 
  attribute :bibliographic_citation, Valkyrie::Types::Set 
  attribute :source, Valkyrie::Types::Set 
  attribute :ocr, Valkyrie::Types::Set 
  attribute :pubplace, Valkyrie::Types::Set 
  attribute :rights, Valkyrie::Types::Set 
  attribute :rights_URI, Valkyrie::Types::Set 
  attribute :rightsHolder, Valkyrie::Types::Set 
  attribute :subject, Valkyrie::Types::Set 
  attribute :subject_URI, Valkyrie::Types::Set 
  attribute :depositor, Valkyrie::Types::Set   
  attribute :date_uploaded, Valkyrie::Types::Set 
  attribute :date_modified, Valkyrie::Types::Set 
  
   
  
  
end

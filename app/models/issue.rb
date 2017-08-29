# frozen_string_literal: true
class Issue < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :id, Valkyrie::Types::ID.optional
  attribute :title, Valkyrie::Types::Set
  attribute :author, Valkyrie::Types::Set
  attribute :testing, Valkyrie::Types::Set
  attribute :member_ids, Valkyrie::Types::Array
  attribute :a_member_of, Valkyrie::Types::Set
  attribute :viewing_hint, Valkyrie::Types::Set
  attribute :viewing_direction, Valkyrie::Types::Set
  attribute :thumbnail_id, Valkyrie::Types::Set
  attribute :representative_id, Valkyrie::Types::Set
  attribute :start_canvas, Valkyrie::Types::Set
  attribute :alternative_title, Valkyrie::Types::Set
  attribute :compiler, Valkyrie::Types::Set
  attribute :editor, Valkyrie::Types::Set
  attribute :translator, Valkyrie::Types::Set
  attribute :format, Valkyrie::Types::Set
  attribute :format_URI, Valkyrie::Types::Set
  attribute :cornell_id, Valkyrie::Types::SingleValuedString
  attribute :repository_location, Valkyrie::Types::Set
  attribute :item_type, Valkyrie::Types::Set
  attribute :item_type_URI, Valkyrie::Types::Set
  attribute :edition, Valkyrie::Types::Set
  attribute :physicalVersion, Valkyrie::Types::Set
  attribute :bibID, Valkyrie::Types::Set 
  attribute :date_uploaded, Valkyrie::Types::Set
  attribute :date_modified, Valkyrie::Types::SingleValuedString
  attribute :depositor, Valkyrie::Types::SingleValuedString
  attribute :label, Valkyrie::Types::Set
  attribute :relative_path, Valkyrie::Types::Set
  attribute :import_url, Valkyrie::Types::Set 
  attribute :resource_type, Valkyrie::Types::Set
  attribute :creator, Valkyrie::Types::Set
  attribute :contributor, Valkyrie::Types::Set 
  attribute :contributor_URI, Valkyrie::Types::Set
  attribute :creator_URI, Valkyrie::Types::Set 
  attribute :note, Valkyrie::Types::Set
  attribute :abstract, Valkyrie::Types::Set
  attribute :publisher, Valkyrie::Types::Set
  attribute :publisher_URI,Valkyrie::Types::Set
  attribute :date_created, Valkyrie::Types::SingleValuedString
  attribute :language_URI, Valkyrie::Types::SingleValuedString 
  attribute :language, Valkyrie::Types::Set 
  attribute :identifier, Valkyrie::Types::Set 
  attribute :based_near, Valkyrie::Types::Set
  attribute :related_url, Valkyrie::Types::Set
  attribute :bibliographic_citation, Valkyrie::Types::Set
  attribute :source,Valkyrie::Types::Set 
  attribute :ocr, Valkyrie::Types::SingleValuedString
  attribute :pubplace, Valkyrie::Types::Set
  attribute :rights, Valkyrie::Types::Set
  attribute :rights_URI, Valkyrie::Types::Set 
  attribute :rightsHolder, Valkyrie::Types::Set
  attribute :subject, Valkyrie::Types::Set
  attribute :subject_URI, Valkyrie::Types::Set
  attribute :date, Valkyrie::Types::Set
  attribute :physicalSource, Valkyrie::Types::Set
  
  attribute :copyrightDate, Valkyrie::Types::Set
  attribute :issuingBody, Valkyrie::Types::Set
  attribute :extent, Valkyrie::Types::Set
  attribute :repository, Valkyrie::Types::Set
  attribute :issue_type, Valkyrie::Types::Set
  attribute :issue_type_URI, Valkyrie::Types::Set
  attribute :placeOfPublication, Valkyrie::Types::Set

  
  
end

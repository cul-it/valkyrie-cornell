# frozen_string_literal: true
class FileSet < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :id, Valkyrie::Types::ID.optional
  attribute :title, Valkyrie::Types::Set
  attribute :file_identifiers, Valkyrie::Types::Set
  attribute :member_ids, Valkyrie::Types::Array
  attribute :awsimage, Valkyrie::Types::Array
  attribute :awsthumbnail, Valkyrie::Types::Array
  attribute :image_width, Valkyrie::Types::Array
  attribute :image_height, Valkyrie::Types::Array
  attribute :image_filename, Valkyrie::Types::Array
  attribute :cornell_id, Valkyrie::Types::SingleValuedString
  attribute :fileset_title, Valkyrie::Types::Array
  attribute :fileset_extent, Valkyrie::Types::SingleValuedString
  attribute :fileset_identifier, Valkyrie::Types::SingleValuedString
  attribute :fileset_note, Valkyrie::Types::Array
  attribute :fileset_rights, Valkyrie::Types::Array
  attribute :fileset_rights_URI, Valkyrie::Types::Array
  attribute :fileset_rightsHolder, Valkyrie::Types::Array
  attribute :mimetype, Valkyrie::Types::Array

end

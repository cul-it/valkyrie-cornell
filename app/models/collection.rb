# frozen_string_literal: true
class Collection < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :id, Valkyrie::Types::ID.optional
  attribute :title, Valkyrie::Types::Set
  attribute :abstract, Valkyrie::Types::Array
  attribute :bib_id, Valkyrie::Types::Array
  attribute :related_url, Valkyrie::Types::Array
  attribute :publisher, Valkyrie::Types::Array
  attribute :publisher_URI, Valkyrie::Types::SingleValuedString
  attribute :date_created, Valkyrie::Types::SingleValuedString
  attribute :subject, Valkyrie::Types::Array
  attribute :curator, Valkyrie::Types::SingleValuedString
  attribute :language, Valkyrie::Types::SingleValuedString
  attribute :alt_title, Valkyrie::Types::SingleValuedString
  attribute :depositor, Valkyrie::Types::SingleValuedString
  attribute :date_uploaded, Valkyrie::Types::SingleValuedString
  attribute :date_modified, Valkyrie::Types::SingleValuedString
  attribute :cornell_id, Valkyrie::Types::SingleValuedString

  end
# frozen_string_literal: true
require 'rails_helper'
require 'valkyrie/specs/shared_specs'
include ActionDispatch::TestProcess

RSpec.describe ChangeSetPersister do
  subject(:change_set_persister) do
    described_class.new(metadata_adapter: adapter, storage_adapter: storage_adapter)
  end
  let(:adapter) { Valkyrie.config.metadata_adapter }
  let(:persister) { adapter.persister }
  let(:query_service) { adapter.query_service }
  let(:storage_adapter) { Valkyrie.config.storage_adapter }
  let(:change_set_class) { BookChangeSet }
  it_behaves_like "a Valkyrie::ChangeSetPersister"
  describe "#save" do
    let(:file) { fixture_file_upload('files/example.tif', 'image/tiff') }
    it "can handle appending to another record" do
      parent_book = persister.save(resource: Book.new)
      change_set = change_set_class.new(Book.new)
      change_set.append_id = parent_book.id

      output = change_set_persister.save(change_set: change_set)
      reloaded_parent = query_service.find_by(id: parent_book.id)

      expect(reloaded_parent.member_ids).to eq [output.id]
    end

    it "can append files" do
      change_set = change_set_class.new(Book.new)
      change_set.files = [file]

      output = change_set_persister.save(change_set: change_set)
      members = query_service.find_members(resource: output)

      expect(members.length).to eq 1
      expect(members[0]).to be_kind_of FileSet
    end
  end

  describe "#delete" do
    it "cleans up parent associations" do
      book = persister.save(resource: Book.new)
      parent = persister.save(resource: Book.new(member_ids: [book.id]))
      change_set = change_set_class.new(book)

      change_set_persister.delete(change_set: change_set)
      reloaded_parent = query_service.find_by(id: parent.id)

      expect(reloaded_parent.member_ids).to be_empty
    end
  end
end

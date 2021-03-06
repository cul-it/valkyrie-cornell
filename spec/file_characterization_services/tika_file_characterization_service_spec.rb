# frozen_string_literal: true

require 'rails_helper'
require 'valkyrie/specs/shared_specs'
include ActionDispatch::TestProcess

RSpec.describe TikaFileCharacterizationService do
  it_behaves_like 'a Valkyrie::FileCharacterizationService'
  let(:file_characterization_service) { described_class }
  let(:adapter) { Valkyrie::MetadataAdapter.find(:indexing_persister) }
  let(:storage_adapter) { Valkyrie.config.storage_adapter }
  let(:persister) { adapter.persister }
  let(:query_service) { adapter.query_service }
  let(:file) { fixture_file_upload('files/example.tif', 'image/tiff') }
  let(:change_set_persister) { ChangeSetPersister.new(metadata_adapter: adapter, storage_adapter: storage_adapter) }
  let(:book) do
    change_set_persister.save(change_set: BookChangeSet.new(Book.new, files: [file]))
  end
  let(:book_change_set) do
    BookChangeSet.new(Book.new).tap do |change_set|
      change_set.files = [file]
    end
  end
  let(:book_members) { query_service.find_members(resource: book) }
  let(:valid_file_set) { book_members.first }
  let(:valid_file_node) { adapter.query_service.find_members(resource: valid_file_set).first }

  before do
    output = '547c81b080eb2d7c09e363a670c46960ac15a6821033263867dd59a31376509c'
    ruby_mock = instance_double(Digest::SHA256, hexdigest: output)
    allow(Digest::SHA256).to receive(:hexdigest).and_return(ruby_mock)
  end

  it 'characterizes a sample file' do
    Valkyrie::FileCharacterizationService.for(file_node: valid_file_node, persister: persister).characterize
  end

  it 'sets the height attribute for a file_node on characterize ' do
    t_file_node = valid_file_node
    t_file_node.height = nil
    new_file_node = Valkyrie::FileCharacterizationService.for(file_node: t_file_node, persister: persister).characterize(save: false)
    expect(new_file_node.height).not_to be_empty
  end

  it 'sets the width attribute for a file_node on characterize' do
    t_file_node = valid_file_node
    t_file_node.width = nil
    new_file_node = Valkyrie::FileCharacterizationService.for(file_node: t_file_node, persister: persister).characterize(save: false)
    expect(new_file_node.width).not_to be_empty
  end

  it 'saves to the persister by default on characterize' do
    allow(persister).to receive(:save).and_return(valid_file_node)
    Valkyrie::FileCharacterizationService.for(file_node: valid_file_node, persister: persister).characterize
    expect(persister).to have_received(:save).once
  end

  it 'does not save to the persister when characterize is called with save false' do
    allow(persister).to receive(:save).and_return(valid_file_node)
    Valkyrie::FileCharacterizationService.for(file_node: valid_file_node, persister: persister).characterize(save: false)
    expect(persister).not_to have_received(:save)
  end

  it 'sets the mime_type for a file_node on characterize' do
    t_file_node = valid_file_node
    t_file_node.mime_type = nil
    new_file_node = Valkyrie::FileCharacterizationService.for(file_node: t_file_node, persister: persister).characterize(save: false)
    expect(new_file_node.mime_type).not_to be_empty
  end

  it 'sets the checksum for a file_node on characterize' do
    t_file_node = valid_file_node
    t_file_node.checksum = nil
    new_file_node = Valkyrie::FileCharacterizationService.for(file_node: t_file_node, persister: persister).characterize(save: false)
    expect(new_file_node.checksum).not_to be_empty
  end
end

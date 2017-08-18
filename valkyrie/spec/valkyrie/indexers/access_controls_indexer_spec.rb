# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Valkyrie::Indexers::AccessControlsIndexer do
  describe ".to_solr" do
    before do
      class Resource < Valkyrie::Resource
        include Valkyrie::Resource::AccessControls
      end
      class SimpleResource < Valkyrie::Resource
      end
    end
    after do
      Object.send(:remove_const, :Resource)
      Object.send(:remove_const, :SimpleResource)
    end
    it "indexes for Hydra::AccessControls" do
      resource = Resource.new(read_users: ["read_user"], edit_users: ["edit_user"], read_groups: ["read_group"], edit_groups: ["edit_group"])
      output = described_class.new(resource: resource).to_solr

      expect(output["read_access_person_ssim"]).to eq ["read_user"]
      expect(output["edit_access_person_ssim"]).to eq ["edit_user"]
      expect(output["read_access_group_ssim"]).to eq ["read_group"]
      expect(output["edit_access_group_ssim"]).to eq ["edit_group"]
    end
    context "when it's passed a resource which has no read_users" do
      it "does nothing" do
        resource = SimpleResource.new(read_users: ["read_user"], edit_users: ["edit_user"], read_groups: ["read_group"], edit_groups: ["edit_group"])
        output = described_class.new(resource: resource).to_solr

        expect(output).to eq({})
      end
    end
  end
end

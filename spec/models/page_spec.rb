# frozen_string_literal: true
require 'rails_helper'
require 'valkyrie/specs/shared_specs'

RSpec.describe Page do
  subject(:book) { described_class.new }
  let(:resource_klass) { described_class }
  it_behaves_like "a Valkyrie::Resource"
end

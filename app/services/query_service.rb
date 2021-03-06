# frozen_string_literal: true
class QueryService
  class_attribute :metadata_adapter
  self.metadata_adapter = Valkyrie.config.metadata_adapter
  class << self
    delegate :find_all, :find_by, :find_by_title, :find_by_cornell_id, :find_members, to: :default_adapter

    def default_adapter
      new(metadata_adapter: metadata_adapter)
    end
  end

  attr_reader :metadata_adapter
  delegate :find_all, :find_by, :find_by_title, :find_by_cornell_id, :find_members, to: :metadata_adapter_query_service
  def initialize(metadata_adapter:)
    @metadata_adapter = metadata_adapter
  end

  delegate :query_service, to: :metadata_adapter, prefix: true
end

# frozen_string_literal: true
module Valkyrie::Persistence::Solr::Queries
  class FindByCornellIdQuery
    attr_reader :cornell_id, :connection, :resource_factory
    def initialize(title, connection:, resource_factory:)
      @cornell_id = cornell_id
      @connection = connection
      @resource_factory = resource_factory
    end

    def run
      raise ::Valkyrie::Persistence::ObjectNotFoundError unless resource
      resource_factory.to_resource(resource)
    end

    def cornell_id
      "#{@cornell_id}"
    end

    def resource
      connection.get("select", params: { q: "cornell_id_tesim:\"#{cornell_id}\"", fl: "*", rows: 1 })["response"]["docs"].first
    end
  end
end

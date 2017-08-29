# frozen_string_literal: true
module Valkyrie::Persistence::Solr::Queries
  class FindByTitleQuery
    attr_reader :title, :connection, :resource_factory
    def initialize(title, connection:, resource_factory:)
      @title = title
      @connection = connection
      @resource_factory = resource_factory
    end

    def run
      raise ::Valkyrie::Persistence::ObjectNotFoundError unless resource
      resource_factory.to_resource(resource)
    end

    def title
      "#{@title}"
    end

    def resource
      connection.get("select", params: { q: "title:\"#{title}\"", fl: "*", rows: 1 })["response"]["docs"].first
    end
  end
end

# frozen_string_literal: true
module Valkyrie::Persistence::Solr::Queries
  class FindMembersQuery
    attr_reader :resource, :connection, :resource_factory
    def initialize(resource:, connection:, resource_factory:)
      @resource = resource
      @connection = connection
      @resource_factory = resource_factory
    end

    def run
      enum_for(:each)
    end

    def each
      unordered_members.sort_by { |x| member_ids.index(x.id) }.each do |member|
        yield member
      end
    end

    def unordered_members
      docs.map do |doc|
        resource_factory.to_resource(doc)
      end
    end

    def docs
      connection.get("select", params: { q: query, rows: 1_000_000_000 })["response"]["docs"]
    end

    def member_ids
      Array.wrap(resource.member_ids)
    end

    def query
      "{!join from=member_ids_ssim to=id}id:#{id}"
    end

    def id
      "id-#{resource.id}"
    end
  end
end

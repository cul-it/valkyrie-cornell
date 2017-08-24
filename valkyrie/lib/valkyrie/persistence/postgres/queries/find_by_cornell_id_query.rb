# frozen_string_literal: true
module Valkyrie::Persistence::Postgres::Queries
  class FindByCornellIdQuery
    attr_reader :cornell_id
    def initialize(cornell_id)
      @cornell_id = cornell_id.to_s
      @id = ""
    end

    def run
      id = ::Valkyrie::Persistence::Postgres::ResourceFactory.return_string(relation)
      id = id.to_param
      ::Valkyrie::Persistence::Postgres::ResourceFactory.to_resource(orm_resource.find(id))
    rescue ActiveRecord::RecordNotFound
      raise Valkyrie::Persistence::ObjectNotFoundError
    end

    private

      def relation
        orm_resource.find_by_sql([query, cornell_id.to_s])
      end
   
      def query
        <<-SQL
        SELECT id FROM orm_resources WHERE metadata->>'cornell_id' = ?
      SQL
      end
      
      def orm_resource
        ::Valkyrie::Persistence::Postgres::ORM::Resource
      end

  end
end

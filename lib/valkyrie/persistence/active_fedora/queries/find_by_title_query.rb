# frozen_string_literal: true
module Valkyrie::Persistence::ActiveFedora::Queries
  class FindByTitleQuery
    attr_reader :title
    def initialize(title)
      @title = title
    end

    def run
      ::Valkyrie::Persistence::ActiveFedora::ResourceFactory.to_resource(relation)
    rescue ActiveFedora::ObjectNotFoundError, ::Ldp::Gone
      raise Valkyrie::Persistence::ObjectNotFoundError
    end

    private

      def relation
        orm_resource.find(title.to_s)
      end

      def orm_resource
        ::Valkyrie::Persistence::ActiveFedora::ORM::Resource
      end
  end
end

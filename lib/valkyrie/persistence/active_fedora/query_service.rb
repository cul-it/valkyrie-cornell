# frozen_string_literal: true
module Valkyrie::Persistence::ActiveFedora
  class QueryService
    class << self
      def find_all
        Valkyrie::Persistence::ActiveFedora::Queries::FindAllQuery.new.run
      end

      def find_all_of_model(model:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindAllQuery.new(model: model).run
      end

      def find_by(id:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindByIdQuery.new(id).run
      end

      def find_by_title(title:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindByTitleQuery.new(title).run
      end

      def find_by_cornell_id(cornell_id:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindByTitleQuery.new(cornell_id).run
      end

      def find_members(resource:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindMembersQuery.new(resource).run
      end

      def find_parents(resource:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindParentsQuery.new(resource).run
      end

      def find_references_by(resource:, property:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindReferencesQuery.new(resource, property).run
      end

      def find_inverse_references_by(resource:, property:)
        Valkyrie::Persistence::ActiveFedora::Queries::FindInverseReferencesQuery.new(resource, property).run
      end
    end
  end
end

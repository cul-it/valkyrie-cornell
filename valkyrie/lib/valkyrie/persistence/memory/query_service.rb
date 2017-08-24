# frozen_string_literal: true
module Valkyrie::Persistence::Memory
  class QueryService
    attr_reader :adapter
    delegate :cache, to: :adapter
    # @param adapter [Valkyrie::Persistence::Memory::MetadataAdapter] The adapter which
    #   has the cache to query.
    def initialize(adapter:)
      @adapter = adapter
    end

    # @param id [Valkyrie::ID] The ID to query for.
    # @raise [Valkyrie::Persistence::ObjectNotFoundError] Raised when the ID
    #   isn't in the persistence backend.
    # @return [Valkyrie::Resource] The object being searched for.
    def find_by(id:)
      cache[id] || raise(::Valkyrie::Persistence::ObjectNotFoundError)
    end

    def find_by_title(title:)
      cache[title] || raise(::Valkyrie::Persistence::ObjectNotFoundError)
    end
 
    def find_by_cornell_id(cornell_id:)
      cache[cornell_id] || raise(::Valkyrie::Persistence::ObjectNotFoundError)
    end

    
    # @return [Array<Valkyrie::Resource>] All objects in the persistence backend.
    def find_all
      cache.values
    end

    # @param resource [Class] Class to query for.
    # @return [Array<Valkyrie::Resource>] All objects in the persistence backend
    #   with the given class.
    def find_all_of_model(model:)
      cache.values.select do |obj|
        obj.is_a?(model)
      end
    end

    # @param resource [Valkyrie::Resource] Model whose members are being searched for.
    # @return [Array<Valkyrie::Resource>] All child objects referenced by `resource`'s
    #   `member_ids` method. Returned in order.
    def find_members(resource:)
      member_ids(resource: resource).map do |id|
        find_by(id: id)
      end
    end

    # @param resource [Valkyrie::Resource] Model whose property is being searched.
    # @param property [Symbol] Property which, on the `resource`, contains {Valkyrie::ID}s which are
    #   to be de-referenced.
    # @return [Array<Valkyrie::Resource>] All objects which are referenced by the
    #   `property` property on `resource`. Not necessarily in order.
    def find_references_by(resource:, property:)
      Array.wrap(resource[property]).map do |id|
        find_by(id: id)
      end
    end

    # @param resource [Valkyrie::Resource] The resource which is being referenced by
    #   other resources.
    # @param property [Symbol] The property which, on other resources, is
    #   referencing the given `resource`
    # @return [Array<Valkyrie::Resource>] All resources in the persistence backend
    #   which have the ID of the given `resource` in their `property` property. Not
    #   in order.
    def find_inverse_references_by(resource:, property:)
      find_all.select do |obj|
        Array.wrap(obj[property]).include?(resource.id)
      end
    end

    # @param resource [Valkyrie::Resource] The resource whose parents are being searched
    #   for.
    # @return [Array<Valkyrie::Resource>] All resources which are parents of the given
    #   `resource`. This means the resource's `id` appears in their `member_ids`
    #   array.
    def find_parents(resource:)
      cache.values.select do |record|
        member_ids(resource: record).include?(resource.id)
      end
    end

    def member_ids(resource:)
      resource.member_ids || []
    end
  end
end

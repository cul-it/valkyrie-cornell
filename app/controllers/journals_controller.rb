# frozen_string_literal: true
class JournalsController < ApplicationController
  include Valkyrie::ControllerConcerns::ModelControllerBehavior
  self.resource_class = Journal

  def append
    @change_set = change_set_class.new(resource_class.new)
    authorize! :update, @change_set.resource
    @change_set.append_id = params[:id]
  end

  def file_manager
    @record = change_set_class.new(find_journal(params[:id])).prepopulate!
    authorize! :file_manager, @record.resource
    @children = QueryService.find_members(resource: @record).map do |x|
      change_set_class.new(x).prepopulate!
    end.to_a
  end

  private

    def change_set_class
      DynamicChangeSetClass.new(params[:resource])
    end

    def resource_class
      Journal
    end

    def resource_params
      params[:journal]
    end
end

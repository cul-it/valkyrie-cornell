# frozen_string_literal: true
require 'benchmark'

num_children = 100

# Pop off the indexing_persister  so we don't test it
Valkyrie.logger.level = :error
Valkyrie::MetadataAdapter.adapters.to_a.each do |adapter_name, adapter|
  Benchmark.bm do |bench|
    parent = Book.new
    children = nil
    bench.report("#{adapter_name} create #{num_children} children") do
      children = []
      if adapter.persister.respond_to?(:buffer_into_index)
        adapter.persister.buffer_into_index do |persist|
          children = Array.new(num_children) do |_page_num|
            p = Page.new
            persist.save(resource: p)
          end
        end
      else
        children = Array.new(num_children) do |_page_num|
          p = Page.new
          adapter.persister.save(resource: p)
        end
      end
    end
    parent.member_ids = children.map(&:id)
    bench.report("#{adapter_name} save parent with #{num_children} children") do
      parent = adapter.persister.save(resource: parent)
    end
    bench.report("#{adapter_name} reload parent with #{num_children} children") do
      parent = adapter.query_service.find_by(id: parent.id)
    end
    last_page = Page.new
    adapter.persister.save(resource: last_page)
    bench.report("#{adapter_name} add one more page to a parent with #{num_children} existing children") do
      parent.member_ids += [last_page.id]
      parent = adapter.persister.save(resource: parent)
    end
  end
end

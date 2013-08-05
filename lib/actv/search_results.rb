require 'actv/base'
require 'actv/facet'
require 'actv/facet_value'

module ACTV
  class SearchResults < ACTV::Base
    attr_reader :items_per_page, :start_index, :total_results

    # @return [Array<ACTV::Asset>]
    def results
      @results ||= Array(@attrs[:results]).map do |asset|
        ACTV::Asset.fetch_or_new(asset)
      end
    end
    
    # @return [Array<ACTV::Facet>]
    def facets
      @facets ||= Array(@attrs[:facets]).map do |facet|
        ACTV::Facet.fetch_or_new(facet)
      end
    end
    
    # @return [Array<ACTV::FacetValue>]
    def facet_values
      @facet_values ||= Array(@attrs[:facet_values]).map do |facet_value|
        ACTV::FacetValue.fetch_or_new(facet_value)
      end
    end
  end
end
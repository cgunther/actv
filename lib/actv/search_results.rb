require 'actv/base'

module ACTV
  class SearchResults < ACTV::Base
    attr_reader :page, :query, :results_per_page

    # @return [Array<ACTV::Asset>]
    def results
      @results ||= Array(@attrs[:results]).map do |asset|
        ACTV::Asset.fetch_or_new(asset)
      end
    end
  end
end
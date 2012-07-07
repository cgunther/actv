require 'active/base'

module Active
  class SearchResults < Active::Base
    attr_reader :page, :query, :results_per_page

    # @return [Array<Active::Asset>]
    def results
      @results ||= Array(@attrs[:results]).map do |asset|
        Active::Asset.fetch_or_new(asset)
      end
    end
  end
end
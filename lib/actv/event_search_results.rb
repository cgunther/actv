require 'actv/search_results'

module ACTV
  class EventSearchResults < ACTV::SearchResults
    def results
      @results ||= Array(@attrs[:results]).map do |article|
        ACTV::Event.fetch_or_create(article)
      end
    end
  end
end
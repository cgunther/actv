require 'actv/search_results'

module ACTV
  class ArticleSearchResults < ACTV::SearchResults
    def results
      @results ||= Array(@attrs[:results]).map do |event|
        ACTV::Article.fetch_or_new(event)
      end
    end
  end
end
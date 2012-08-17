require 'actv/search_results'

module ACTV
  class ArticleSearchResults < ACTV::SearchResults
    def results
      @results ||= Array(@attrs[:results]).map do |article|
        ACTV::Article.fetch_or_new(article)
      end
    end
  end
end
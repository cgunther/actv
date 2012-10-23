require 'spec_helper'

describe ACTV::Client do
  before do
    @client = ACTV::Client.new
  end

  describe "#article" do
    context "with a valid article ID passed" do
      before do
        stub_get("/v2/assets/valid_article.json").
        to_return(body: fixture("valid_article.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      before(:each) do
        @article = @client.article("valid_article")
      end

      it "requests the correct article" do
        a_get("/v2/assets/valid_article.json").should have_been_made
      end

      it "should return the correct summary" do
        @article.summary.should include "Running can be endlessly"
      end

      it "should return the correct description" do
        @article.description.should include "One of the great virtues"
      end

      it "should return the correct by line" do
        @article.by_line.should eq "By Greg Tymon, M.Ed., C.S.C.S."
      end

      it "should return the correct source" do
        @article.source.should include "American Running Association"
      end

      it "should return the correct author photo" do
        @article.author_photo.name.should eq "authorImage"
        @article.author_photo.url.should eq "http://www.active.com/AssetFactory.aspx?did=50534"
        @article.author_photo.caption.should eq "Author"
      end

      it "should return the correct author bio" do
        @article.author_bio.should eq "Author Bio"
      end

      it "should return the correct type" do
        @article.type.should eq "Article"
      end
    end
  end

  describe "#articles" do
    context "performs an article search with no results" do
      before do
        stub_get("/v2/search.json?query=asdf&category=articles").
        to_return(body: fixture("valid_search_no_results.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      before(:each) do
        @search_results = @client.articles('asdf')
      end
      
      it 'returns an empty array of assets in results' do
        @search_results.results.size.should eql 0
      end
      
      it 'returns an empty array of facets' do
        @search_results.facets.size.should eql 0
      end
      
      it 'returns an empty array of facet_values in results' do
        @search_results.facet_values.size.should eql 0
      end
    end
    
    context "performs a search with results" do
      before do
        stub_get("/v2/search.json?query=running&category=articles").
        to_return(body: fixture("valid_search.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      before(:each) do
        @search_results = @client.articles('running')
      end
      
      it 'returns the correct array of assets in the results' do
        @search_results.results.first.assetName.should eql 'Running 5K'
        @search_results.results.size.should eql 5
      end
      
      it 'returns the correct array of facets' do
        @search_results.facets.size.should eql 1
        @search_results.facets.first.name.should eql 'topicName'
      end
      
      it 'returns the correct array of facet_values' do
        @search_results.facet_values.first.name.should eql 'topicName'
        @search_results.facet_values.first.value.should eql 'Running'
      end
    end

    describe "#popular_articles" do
      context 'performs a search with results' do
        before do
          stub_get("/v2/articles/popular").
          to_return(body: fixture("valid_search.json"), headers: { content_type: "application/json; charset=utf-8" })
        end

        it 'returns an array of popular articles' do
            search_results = @client.popular_articles()
            search_results.results.size.should eql 5
        end
      end

      context "performs an popular search with no results" do
        before do
          stub_get("/v2/articles/popular?topic=asdf").
          to_return(body: fixture("valid_search_no_results.json"), headers: { content_type: "application/json; charset=utf-8" })        
        end

        it 'returns an empty array of assets in results' do
          search_results = @client.popular_articles({'topic' => 'asdf'})        
          search_results.results.size.should eql 0
        end      
      end
    end
    
  end
end
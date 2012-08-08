require 'spec_helper'

describe ACTV::Client do

  before do
    @client = ACTV::Client.new
  end

  describe "#assets aka #search" do
    context "performs a search with no results" do
      before do
        stub_get("/v2/search.json?query=asdf").
        to_return(body: fixture("valid_search_no_results.json"), headers: { content_type: "application/json; charset=utf-8" })
      end
      
      it 'returns an empty array of assets in results' do
        search_results = @client.assets('asdf')
        search_results.results.size.should eql 0
      end
      
      it 'returns an empty array of facets' do
        search_results = @client.assets('asdf')
        search_results.facets.size.should eql 0
      end
      
      it 'returns an empty array of facet_values in results' do
        search_results = @client.assets('asdf')
        search_results.facet_values.size.should eql 0
      end
    end
    
    context "performs a search with results" do
      before do
        stub_get("/v2/search.json?query=running").
        to_return(body: fixture("valid_search.json"), headers: { content_type: "application/json; charset=utf-8" })
      end
      
      it 'returns the correct array of assets in the results' do
        search_results = @client.assets('running')
        search_results.results.first.assetName.should eql 'Running 5K'
        search_results.results.size.should eql 5
      end
      
      it 'returns the correct array of facets' do
        search_results = @client.assets('running')
        search_results.facets.size.should eql 1
        search_results.facets.first.name.should eql 'topicName'
      end
      
      it 'returns the correct array of facet_values' do
        search_results = @client.assets('running')
        search_results.facet_values.first.name.should eql 'topicName'
        search_results.facet_values.first.value.should eql 'Running'
      end
    end
    
  end
end
require 'spec_helper'

describe ACTV::Client do

  before do
    @client = ACTV::Client.new
  end

  describe "#popular_events" do
    context "performs a search with results" do
      before do
        stub_get("/v2/events/popular").
        to_return(body: fixture("valid_search.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      it 'returns an array of popular events' do
        search_results = @client.popular_events()
        search_results.results.size.should eql 5
      end
    end

    context "performs a search with no results" do
      before do
        stub_get("/v2/events/popular?topic=asdf").
        to_return(body: fixture("valid_search_no_results.json"), headers: { content_type: "application/json; charset=utf-8" })        
      end

      it 'returns an empty array of assets in results' do
        search_results = @client.popular_events({'topic' => 'asdf'})        
        search_results.results.size.should eql 0
      end
    end
  end

  describe "#upcoming_events" do
    context 'performs a search with results' do
      before do
        stub_get("/v2/events/upcoming").
        to_return(body: fixture("valid_search.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      it 'returns an array of upcoming_events' do
          search_results = @client.upcoming_events()
          search_results.results.size.should eql 5
      end
    end

    context "performs a search with no results" do
      before do
        stub_get("/v2/events/popular?topic=asdf").
        to_return(body: fixture("valid_search_no_results.json"), headers: { content_type: "application/json; charset=utf-8" })        
      end

      it 'returns an empty array of assets in results' do
        search_results = @client.popular_events({'topic' => 'asdf'})        
        search_results.results.size.should eql 0
      end
    end
  end

end
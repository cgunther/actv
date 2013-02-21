require 'spec_helper'

describe ACTV::Client do

  before do
    @client = ACTV::Client.new
  end

  describe "#event" do
    context "with a valid event ID passed" do
      before do
        stub_get("/v2/assets/valid_event.json").
        to_return(body: fixture("valid_event.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      before(:each) do
        @event = @client.event("valid_event")
      end

      it "requests the correct event" do
        a_get("/v2/assets/valid_event.json").should have_been_made
      end

      it "has online reigstration available" do
        @event.online_registration_available?.should eq true
      end

      it "does not have registration not yet open" do
        @event.registration_not_yet_open?.should eq false
      end

      it "does not have registration open" do
        @event.registration_open?.should eq false
      end

      it "has registration closed" do
        @event.activityEndDate = "2013-07-24T00:00:00"
        @event.registration_closed?.should eq true
      end

      it "has ended" do
        @event.ended?.should eq true
      end
    end
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
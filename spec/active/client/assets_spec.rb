require 'spec_helper'

describe Active::Client do

  before do
    @client = Active::Client.new
  end

  describe "#asset" do
    context "with a valid asset ID passed" do
      before do
        stub_get("/v2/assets/BA288960-2718-4B20-B380-8F939596BB59.json").
        to_return(body: fixture("BA288960-2718-4B20-B380-8F939596BB59.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      it "it requests the correct asset" do
        @client.asset("BA288960-2718-4B20-B380-8F939596BB59")
        a_get("/v2/assets/BA288960-2718-4B20-B380-8F939596BB59.json").should have_been_made
      end
    end
  end

end
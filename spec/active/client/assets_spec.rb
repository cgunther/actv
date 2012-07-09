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

      it "requests the correct asset" do
        @client.asset("BA288960-2718-4B20-B380-8F939596BB59")
        a_get("/v2/assets/BA288960-2718-4B20-B380-8F939596BB59.json").should have_been_made
      end

      it "returns the correct place" do
        asset = @client.asset("BA288960-2718-4B20-B380-8F939596BB59")
        asset.place.name.should eq 'Kingwood Park New Jersey'
      end

      it "returns the correct description" do
        asset = @client.asset("BA288960-2718-4B20-B380-8F939596BB59")
        asset.descriptions.size.should eq 1
        asset.descriptions.first.description.should eq 'The Run Daddy Run Event is the HCM Foundation way to bring the community together on Fathers Day Weekend to celebrate Fathers and their families.  100% of the proceeds will go to HCM service & scholarship programs.'
      end

      it "returns the correct status" do
        asset = @client.asset("BA288960-2718-4B20-B380-8F939596BB59")
        asset.status.name.should eq 'VISIBLE'
      end

      it "returns the correct legacy data" do
        asset = @client.asset("BA288960-2718-4B20-B380-8F939596BB59")
        asset.legacy_data.online_registration?.should eq "true"
      end
    end
  end

end
require 'spec_helper'

describe ACTV::Client do

  before do
    @client = ACTV::Client.new
  end

  describe "#me" do
    context "with a valid access token" do
      before do
        stub_get("/v2/me.json").
          to_return(body: fixture("me.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      it "requests the correct user" do
        @client.me
        a_get("/v2/me.json").should have_been_made
      end

      it "returns the correct name" do
        me = @client.me
        me.first_name.should eq 'John'
        me.last_name.should eq 'Smith'
      end
    end
  end

end
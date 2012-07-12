require 'spec_helper'

describe ACTV::Client do
  
  before do
    @client = ACTV::Client.new
  end
  
  describe "#system_health" do
    before do
      stub_get("/system_health").
        to_return(:body => fixture("system_health.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
  end
  
end
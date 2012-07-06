require 'spec_helper'

describe Active::Client do
  
  before do
    @client = Active::Client.new
  end
  
  describe "#system_health" do
    before do
      stub_get("/system_health").
        to_return(:body => fixture("system_health.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    
  end
  
end
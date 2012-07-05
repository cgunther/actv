require 'spec_helper'

describe Active::Client do
  
  subject do
    client = Active::Client.new
    # client.class_eval{public *Active::Client.private_instance_methods}
    client
  end
  
  context "with module configuration" do
    
    before  do
      Active.configure do |config|
        Active::Configurable.keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end
    
    after do
      Active.reset!
    end
    
    it "inherits the module configuration" do
      client = Active::Client.new
      Active::Configurable.keys.each do |key|
        client.instance_variable_get("@#{key}").should eq key
      end
    end
    
  end
  
end
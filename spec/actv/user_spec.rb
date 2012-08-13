require 'spec_helper'

describe ACTV::User do
  
  describe "#==" do
    it "returns true when object IDs are the same" do
      user = ACTV::User.new(id: 1, first_name: 'Tom')
      other = ACTV::User.new(id: 1, first_name: 'Tim')
      (user == other).should be_true
    end

    it "returns false when object IDs are different" do
      user = ACTV::User.new(id: 1, first_name: 'Tim')
      other = ACTV::User.new(id: 2, first_name: 'Tim')
      (user == other).should be_false
    end

    it "returns false when classes are different" do
      user = ACTV::User.new(id: 1)
      other = ACTV::Identity.new(id: 1)
      (user == other).should be_false
    end
  end

end
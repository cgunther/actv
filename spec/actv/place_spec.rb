require 'spec_helper'

describe ACTV::Place do

  describe "#==" do
    it "return true when objects IDs are the same" do
      asset = ACTV::Place.new(placeGuid: 1, placeName: "Place 1")
      other = ACTV::Place.new(placeGuid: 1, placeName: "Place 2")
      (asset == other).should be_true
    end

    it "return false when objects IDs are different" do
      asset = ACTV::Place.new(placeGuid: 1)
      other = ACTV::Place.new(placeGuid: 2)
      (asset == other).should be_false
    end

    it "return false when classes are different" do
      asset = ACTV::Place.new(placeGuid: 1)
      other = ACTV::Identity.new(id: 1)
      (asset == other).should be_false
    end
  end

end
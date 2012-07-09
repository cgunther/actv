require 'spec_helper'

describe Active::Place do

  describe "#==" do
    it "return true when objects IDs are the same" do
      asset = Active::Place.new(placeGuid: 1, placeName: "Place 1")
      other = Active::Place.new(placeGuid: 1, placeName: "Place 2")
      (asset == other).should be_true
    end

    it "return false when objects IDs are different" do
      asset = Active::Place.new(placeGuid: 1)
      other = Active::Place.new(placeGuid: 2)
      (asset == other).should be_false
    end

    it "return false when classes are different" do
      asset = Active::Place.new(placeGuid: 1)
      other = Active::Identity.new(id: 1)
      (asset == other).should be_false
    end
  end

end
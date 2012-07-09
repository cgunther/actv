require 'spec_helper'

describe Active::Asset do

  describe "#==" do
    it "return true when objects IDs are the same" do
      asset = Active::Asset.new(assetGuid: 1, assetName: "Title 1")
      other = Active::Asset.new(assetGuid: 1, assetName: "Title 2")
      (asset == other).should be_true
    end

    it "return false when objects IDs are different" do
      asset = Active::Asset.new(assetGuid: 1)
      other = Active::Asset.new(assetGuid: 2)
      (asset == other).should be_false
    end

    it "return false when classes are different" do
      asset = Active::Asset.new(assetGuid: 1)
      other = Active::Identity.new(id: 1)
      (asset == other).should be_false
    end
  end

  describe "#place" do
    it "returns a Place when place is set" do
      place = Active::Asset.new(assetGuid: 1, assetName: "Asset #1", place: { placeGuid: 1, placeName: "Name #1" }).place
      place.should be_a Active::Place
    end

    it "return nil when place is not set" do
      place = Active::Asset.new(assetGuid: 1, assetName: "Asset #1").place
      place.should be_nil
    end
  end

  describe "#descriptions" do
    it "returns an Array of Asset Descriptions when assetDescriptions is set" do
      descriptions = Active::Asset.new(assetGuid: 1, assetName: "Asset #1", assetDescriptions: [{ description: "Description #1" }, { description: "Description #2" }]).descriptions
      descriptions.should be_a Array
      descriptions.first.should be_a Active::AssetDescription
    end

    it "returns an empty array when assetDescriptions is not set" do
      descriptions = Active::Asset.new(assetGuid: 1, assetName: "Asset #1").descriptions
      descriptions.should be_a Array
      descriptions.should eq []
    end
  end

end
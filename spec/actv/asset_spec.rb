require 'spec_helper'

describe ACTV::Asset do

  describe "#==" do
    it "return true when objects IDs are the same" do
      asset = ACTV::Asset.new(assetGuid: 1, assetName: "Title 1")
      other = ACTV::Asset.new(assetGuid: 1, assetName: "Title 2")
      (asset == other).should be_true
    end

    it "return false when objects IDs are different" do
      asset = ACTV::Asset.new(assetGuid: 1)
      other = ACTV::Asset.new(assetGuid: 2)
      (asset == other).should be_false
    end

    it "return false when classes are different" do
      asset = ACTV::Asset.new(assetGuid: 1)
      other = ACTV::Identity.new(id: 1)
      (asset == other).should be_false
    end
  end

  describe "#place" do
    it "returns a Place when place is set" do
      place = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", place: { placeGuid: 1, placeName: "Name #1" }).place
      place.should be_a ACTV::Place
    end

    it "return nil when place is not set" do
      place = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").place
      place.should be_nil
    end
  end

  describe "#descriptions" do
    it "returns an Array of Asset Descriptions when assetDescriptions is set" do
      descriptions = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", assetDescriptions: [{ description: "Description #1" }, { description: "Description #2" }]).descriptions
      descriptions.should be_a Array
      descriptions.first.should be_a ACTV::AssetDescription
    end

    it "returns an empty array when assetDescriptions is not set" do
      descriptions = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").descriptions
      descriptions.should be_a Array
      descriptions.should eq []
    end
  end

  describe "#status" do
    it "returns a Asset Status when assetStatus is set" do
      status = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", assetStatus: { assetStatusId: 1, assetStatusName: "Status #1", isSearchable: true }).status
      status.should be_a ACTV::AssetStatus
    end

    it "returns nil when assetStatus is not set" do
      status = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").status
      status.should be_nil
    end
  end

  describe "#legacy_data" do
    it "returns a Asset Legacy Data when assetLegacyData is set" do
      legacy_data = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", assetLegacyData: { assetTypeId: 1, typeName: "Legacy Data", isSearchable: true }).legacy_data
      legacy_data.should be_a ACTV::AssetLegacyData
    end

    it "returns nil when assetLegacyData is not set" do
      legacy_data = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").status
      legacy_data.should be_nil
    end
  end

  describe "#images" do
    it "returns an Array of Asset Images when assetImages is set" do
      images = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", assetImages: [{ imageUrlAdr: "img1.jpg" }, { imageUrlAdr: "img2.jpg" }]).images
      images.should be_a Array
      images.first.should be_a ACTV::AssetImage
    end

    it "returns an empty array when assetImages is not set" do
      images = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").images
      images.should be_a Array
      images.should eq []
    end
  end

  describe "#tags" do
    it "returns an Array of Asset Tags when assetTags is set" do
      tags = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", assetTags: [{ tag: { tagId: 1, tagName: "Tag" } }]).tags
      tags.should be_a Array
      tags.first.should be_a ACTV::AssetTag
    end

    it "returns an empty array when assetImages is not set" do
      tags = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").tags
      tags.should be_a Array
      tags.should eq []
    end
  end

  describe "#components" do
    it "returns an Array of Asset Components when assetComponents is set" do
      components = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1", assetComponents: [{ assetGuid: 1}]).components
      components.should be_a Array
      components.first.should be_a ACTV::AssetComponent
    end

    it "returns an empty array when assetComponents is not set" do
      components = ACTV::Asset.new(assetGuid: 1, assetName: "Asset #1").tags
      components.should be_a Array
      components.should eq []
    end
  end

end
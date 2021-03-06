require 'spec_helper'

describe ACTV::AssetStatus do

  describe "#==" do
    it "return true when objects IDs are the same" do
      asset = ACTV::AssetStatus.new(assetStatusId: 1, assetStatusName: "Status 1")
      other = ACTV::AssetStatus.new(assetStatusId: 1, assetStatusName: "Status 2")
      (asset == other).should be_true
    end

    it "return false when objects IDs are different" do
      asset = ACTV::AssetStatus.new(assetStatusId: 1)
      other = ACTV::AssetStatus.new(assetStatusId: 2)
      (asset == other).should be_false
    end

    it "return false when classes are different" do
      asset = ACTV::AssetStatus.new(assetStatusId: 1)
      other = ACTV::Identity.new(id: 1)
      (asset == other).should be_false
    end
  end
end
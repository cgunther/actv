require 'spec_helper'

describe Active::AssetStatus do

  describe "#==" do
    it "return true when objects IDs are the same" do
      asset = Active::AssetStatus.new(assetStatusId: 1, assetStatusName: "Status 1")
      other = Active::AssetStatus.new(assetStatusId: 1, assetStatusName: "Status 2")
      (asset == other).should be_true
    end

    it "return false when objects IDs are different" do
      asset = Active::AssetStatus.new(assetStatusId: 1)
      other = Active::AssetStatus.new(assetStatusId: 2)
      (asset == other).should be_false
    end

    it "return false when classes are different" do
      asset = Active::AssetStatus.new(assetStatusId: 1)
      other = Active::Identity.new(id: 1)
      (asset == other).should be_false
    end
  end
end
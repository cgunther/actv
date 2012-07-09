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

end
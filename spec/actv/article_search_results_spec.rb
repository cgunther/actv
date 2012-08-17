require 'spec_helper'

describe ACTV::ArticleSearchResults do
  describe '#results' do
    it 'should return an array of ACTV::Article when results is set' do
      results = ACTV::ArticleSearchResults.new({results: [{assetGuid: '123', assetName: 'test1'}, {assetGuid: '345', assetName: 'test2'}]}).results
      results.should be_a Array
      results.first.should be_a ACTV::Article
    end
    
    it 'should return an emtpy array when results is not set' do
      results = ACTV::ArticleSearchResults.new({}).results
      results.should eql []
    end
  end
end
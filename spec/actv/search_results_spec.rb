require 'spec_helper'

describe ACTV::SearchResults do
  
  describe '#results' do
    it 'should return an array of ACTV::Asset when results is set' do
      results = ACTV::SearchResults.new({results: [{assetGuid: '123', assetName: 'test1'}, {assetGuid: '345', assetName: 'test2'}]}).results
      results.should be_a Array
      results.first.should be_a ACTV::Asset
    end
    
    it 'should return an emtpy array when results is not set' do
      results = ACTV::SearchResults.new({}).results
      results.should eql []
    end
  end

  describe '#facets' do
    it 'should return an array of ACTV::Facet when facets is set' do
      facets = ACTV::SearchResults.new({facets: [{name: "topicName", terms: [{term: "Running", count: 10}, {term: "Cycling", count: 15}]}, {name: "cityName", terms: [{term: "San Diego", count: 20}]}]}).facets
      facets.should be_a Array
      facets.first.should be_a ACTV::Facet
    end
    
    it 'should return an emtpy array when facets is not set' do
      facets = ACTV::SearchResults.new({}).facets
      facets.should eql []
    end
  end

  describe '#facet_values' do
    it 'should return an array of ACTV::FacetValue when facet_values is set' do
      facet_values = ACTV::SearchResults.new({facet_values: [{name: "topicName", value: "Running", count: 25}, {name: "topicName", value: "Cycling", count: 10}]}).facet_values
      facet_values.should be_a Array
      facet_values.first.should be_a ACTV::FacetValue
    end
    
    it 'should return an emtpy array when facets is not set' do
      facets = ACTV::SearchResults.new({}).facet_values
      facets.should eql []
    end
  end

end
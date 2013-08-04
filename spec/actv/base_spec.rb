require 'spec_helper'

describe ACTV::Base do

  context 'identity map enabled' do
    before do
      object = ACTV::Base.new(:id => 1)
      @base = ACTV::Base.store(object)
    end

    describe "#[]" do
      it "calls methods using [] with symbol" do
        @base[:object_id].should be_an Integer
      end

      it "calls methods using [] with string" do
        @base['object_id'].should be_an Integer
      end

      it "returns nil for missing method" do
        @base[:foo].should be_nil
        @base['foo'].should be_nil
      end
    end

    describe "#to_hash" do
      it "returns a hash" do
        @base.to_hash.should be_a Hash
        @base.to_hash[:id].should eq 1
      end
    end

    describe "identical objects" do
      it "have the same object_id" do
        @base.object_id.should eq ACTV::Base.fetch(:id => 1).object_id
      end
    end

    describe '.fetch' do
      it 'returns existing objects' do
        ACTV::Base.fetch(:id => 1).should be
      end

      it "raises an error on objects that don't exist" do
        lambda {
          ACTV::Base.fetch(:id => 6)
        }.should raise_error(ACTV::IdentityMapKeyError)
      end
    end

    describe '.store' do
      it 'stores ACTV::Base objects' do
        object = ACTV::Base.new(:id => 1)
        ACTV::Base.store(object).should be_a ACTV::Base
      end
    end

    describe '.fetch_or_new' do
      it 'returns existing objects' do
        ACTV::Base.fetch_or_new(:id => 1).should be
      end

      it 'creates new objects and stores them' do
        ACTV::Base.fetch_or_new(:id => 2).should be

        ACTV::Base.fetch(:id => 2).should be
      end
    end

    describe "#[]" do
      it "calls methods using [] with symbol" do
        @base[:object_id].should be_an Integer
      end
      it "calls methods using [] with string" do
        @base['object_id'].should be_an Integer
      end
      it "returns nil for missing method" do
        @base[:foo].should be_nil
        @base['foo'].should be_nil
      end
    end
  end

  context 'identity map disabled' do
    before(:all) do
      ACTV.identity_map = false
    end

    after(:all) do
      ACTV.identity_map = ACTV::IdentityMap.new
    end

    describe '.fetch' do
      it 'returns nil' do
        ACTV::Base.fetch(:id => 1).should be_nil
      end
    end

    describe '.store' do
      it 'returns an instance of the object' do
        ACTV::Base.store(ACTV::Base.new(:id => 1)).should be_a ACTV::Base
      end
    end

    describe '.fetch_or_new' do
      it 'creates new objects' do
        ACTV::Base.fetch_or_new(:id => 2).should be
        ACTV.identity_map.should be_false
      end
    end
  end
end
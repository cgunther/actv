require 'spec_helper'

describe ACTV::AssetImage do

  before(:each) do
    @img = ACTV::AssetImage.new(imageUrlAdr: 'http://test.com/1.jpg', imageName: 'image1', imageCaptionTxt: 'caption1')
  end

  describe "attribute accessors and aliases" do
    subject { @img }

    its(:url){ should eq 'http://test.com/1.jpg' }
    its(:name){ should eq 'image1' }
    its(:caption){ should eq 'caption1' }

    its(:imageUrlAdr){ should eq 'http://test.com/1.jpg' }
    its(:imageName){ should eq 'image1' }
    its(:imageCaptionTxt){ should eq 'caption1' }
  end

end

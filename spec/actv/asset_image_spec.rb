require 'spec_helper'

describe ACTV::AssetImage do

  before(:each) do
    @img = ACTV::AssetImage.new(imageUrlAdr: 'http://test.com/1.jpg', 
      imageName: 'image1', imageCaptionTxt: 'caption1', linkUrl: 'http://test.com/',
      linkTarget: '_blank')
  end

  describe "attribute accessors and aliases" do
    subject { @img }

    its(:url){ should eq 'http://test.com/1.jpg' }
    its(:name){ should eq 'image1' }
    its(:caption){ should eq 'caption1' }
    its(:link){ should eq 'http://test.com/'}
    its(:target){ should eq '_blank' }

    its(:imageUrlAdr){ should eq 'http://test.com/1.jpg' }
    its(:imageName){ should eq 'image1' }
    its(:imageCaptionTxt){ should eq 'caption1' }
    its(:linkUrl){ should eq 'http://test.com/'}
    its(:linkTarget){ should eq '_blank' }
  end

end
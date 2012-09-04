require 'spec_helper'

describe ACTV::Article do
  context "shoulda matchers" do
    subject { ACTV::Article.new(assetGuid: 1) }

    it { should respond_to :summary }
    it { should respond_to :description }
    it { should respond_to :by_line }
    it { should respond_to :author_bio }
    it { should respond_to :author_photo }
    it { should respond_to :source }
    it { should respond_to :type }
    it { should respond_to :image }
    it { should respond_to :subtitle }
    it { should respond_to :footer }
  end
end
require 'spec_helper'

describe ACTV::Event do
  context "shoulda matchers" do
    subject { ACTV::Event.new(assetGuid: 1) }

    it { should respond_to :online_registration? }
    it { should respond_to :registration_not_yet_open? }
    it { should respond_to :registration_open? }
    it { should respond_to :registration_closed? }
    it { should respond_to :ended? }
  end
end
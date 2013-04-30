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


  context 'ended?' do

    before(:each) do
      stub_get("/v2/assets/valid_event.json").
        to_return(body: fixture("valid_event.json"), headers: { content_type: "application/json; charset=utf-8" })
      @event = ACTV.event('valid_event')
    end

    it "should return true if start date and end date are different and end date has passed" do
      @event.ended?.should be_true
    end

    it "should return false if start date and end date are different and end date has not passed" do
      today = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
      tomorrow = (Time.now + (24*60*60)).strftime('%Y-%m-%dT%H:%M:%S')

      @event.stub(:start_date).and_return(today)
      @event.stub(:end_date).and_return(tomorrow)

      @event.ended?.should be_false
    end    

    it "should return false if today is the event date of a one day event" do
      today = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
      
      @event.stub(:start_date).and_return(today)
      @event.stub(:end_date).and_return(today)

      @event.ended?.should be_false
    end

  end
end
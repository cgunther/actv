require 'spec_helper'
require "active_support/time"

describe ACTV::Event do
  before do
    stub_get("/v2/assets/valid_event.json").to_return(body: fixture("valid_event.json"), headers: { content_type: "application/json; charset=utf-8" })
  end

  subject { ACTV.event('valid_event') }

  def format_date date
    date.strftime('%Y-%m-%dT%H:%M:%S')
  end
  def format_date_in_utc date
    format_date(date) << ' UTC'
  end

  # describe "available methods" do
  #   subject { ACTV::Event.new(assetGuid: 1) }

  #   it { should respond_to :online_registration_available? }
  #   it { should respond_to :registration_not_yet_open? }
  #   it { should respond_to :registration_open? }
  #   it { should respond_to :registration_closed? }
  #   it { should respond_to :event_ended? }
  # end

  describe '#online_registration_available?' do
    it "returns true if the registration flag is true" do
      subject.online_registration_available?.should be_true
    end

    it "returns false if the registration flag is not true" do
      subject.legacy_data.stub(:onlineRegistration).and_return("false")
      subject.online_registration_available?.should be_false
    end

    it "return false if the registration flag is not present" do
      subject.legacy_data.stub(:onlineRegistration).and_return(nil)
      subject.online_registration_available?.should be_false
    end
  end

  describe '#registration_open_date' do
    before { subject.stub(:sales_start_date).and_return format_date 1.day.from_now }
    it "returns the correct date in the correct timezone" do
      subject.registration_open_date.should be_within(1.second).of Time.parse format_date_in_utc 1.day.from_now
    end
  end

  describe '#registration_close_date' do
    before { subject.stub(:sales_end_date).and_return format_date 1.day.from_now }
    it "returns the correct date in the correct timezone" do
      subject.registration_close_date.should be_within(1.second).of Time.parse format_date_in_utc 1.day.from_now
    end
  end

  describe '#event_start_date' do
    before do
      subject.stub(:activity_start_date).and_return("2013-05-10T00:00:00")
      subject.stub(:timezone_offset).and_return(-4)
    end
    it "returns the correct date in the correct timezone" do
      subject.event_start_date.should eq Time.parse "2013-05-10T00:00:00 -0400"
    end
  end

  describe '#event_end_date' do
    before do
      subject.stub(:activity_end_date).and_return("2013-05-10T00:00:00")
      subject.stub(:timezone_offset).and_return(-4)
    end
    it "returns the correct date in the correct timezone" do
      subject.event_end_date.should eq Time.parse "2013-05-10T00:00:00 -0400"
    end
  end

  describe '#registration_not_yet_open' do

    context 'when the event has sales start date' do
      context 'when now is before the date' do
        before do
          subject.stub(:sales_start_date).and_return format_date 1.day.from_now
        end
        its(:registration_not_yet_open?) { should be_true }
      end
      context 'when now is after the date' do
        before do
          subject.stub(:sales_start_date).and_return format_date 1.day.ago
        end
        its(:registration_not_yet_open?) { should be_false }
      end
    end
    context 'when the event does not have a sales start date' do
      before do
        subject.stub(:sales_start_date).and_return ''
      end
      its(:registration_not_yet_open?) { should be_false }

      context 'when the event has no dates' do
        before do
          subject.stub(:sales_start_date).and_return ''
          subject.stub(:sales_end_date).and_return ''
          subject.stub(:activity_start_date).and_return ''
          subject.stub(:activity_end_date).and_return ''
        end
        its(:registration_not_yet_open?) { should be_false }
      end
    end
  end

  describe '#registration_closed' do

    context 'when the event has sales end date' do
      context 'when now is before the date' do
        before do
          subject.stub(:sales_end_date).and_return format_date 1.day.from_now
        end
        its(:registration_closed?) { should be_false }
      end
      context 'when now is after the date' do
        before do
          subject.stub(:sales_end_date).and_return format_date 1.day.ago
        end
        its(:registration_closed?) { should be_true }
      end
    end
    context 'when the event does not have a sales end date' do
      before do
        subject.stub(:sales_end_date).and_return ''
      end
      context 'when the event has an activity end date' do
        context 'when now is before the date' do
          before do
            subject.stub(:activity_end_date).and_return format_date 1.day.from_now
          end
          its(:registration_closed?) { should be_false }
        end
        context 'when now is after the date' do
          before do
            subject.stub(:activity_end_date).and_return format_date 1.day.ago
          end
          its(:registration_closed?) { should be_true }
        end
      end
      context 'when the event has no dates' do
        before do
          subject.stub(:sales_start_date).and_return ''
          subject.stub(:sales_end_date).and_return ''
          subject.stub(:activity_start_date).and_return ''
          subject.stub(:activity_end_date).and_return ''
        end
        its(:registration_closed?) { should be_false }
      end
    end
  end

  describe '#registration_open' do
    subject { ACTV.event('valid_event') }

    context 'when the event is unregisterable' do
      before do
        subject.stub(:online_registration_available?).and_return false
      end
      its(:registration_open?) { should be_false }
    end

    context 'when the event has sales start and end dates' do
      context 'when now is between start and end dates' do
        before do
          subject.stub(:sales_start_date).and_return format_date 1.day.ago
          subject.stub(:sales_end_date).and_return format_date 1.day.from_now
        end
        its(:registration_open?) { should be_true }
      end

      context 'when now is before start' do
        before do
          subject.stub(:sales_start_date).and_return format_date 1.day.from_now
          subject.stub(:sales_end_date).and_return format_date 2.days.from_now
        end
        its(:registration_open?) { should be_false }
      end

      context 'when now is after end' do
        before do
          subject.stub(:sales_start_date).and_return format_date 2.days.ago
          subject.stub(:sales_end_date).and_return format_date 1.day.ago
        end
        its(:registration_open?) { should be_false }
      end
    end

    context 'when the event does not have sales start and end dates' do
      before do
        subject.stub(:sales_start_date).and_return ''
        subject.stub(:sales_end_date).and_return ''
      end
      context 'when the event has activity start and end dates' do
        before do
          subject.stub(:activity_start_date).and_return format_date 2.days.ago
          subject.stub(:activity_end_date).and_return format_date 2.days.from_now
        end
        context 'when now is between start and end dates' do
          before do
            subject.stub(:activity_start_date).and_return format_date 2.days.ago
            subject.stub(:activity_end_date).and_return format_date 2.days.from_now
          end
          its(:registration_open?) { should be_true }
        end
        context 'when now is after end' do
          before do
            subject.stub(:activity_start_date).and_return format_date 3.days.ago
            subject.stub(:activity_end_date).and_return format_date 2.days.ago
          end
          its(:registration_open?) { should be_false }
        end
      end
      context 'when the event does not have activity start and end dates' do
        before do
          subject.stub(:activity_start_date).and_return ''
          subject.stub(:activity_end_date).and_return ''
        end
        its(:registration_open?) { should be_true } # ask Huiwen
      end
    end
  end
end
  #     before(:each) do
  #       stub_get("/v2/assets/valid_event.json").
  #         to_return(body: fixture("valid_event.json"), headers: { content_type: "application/json; charset=utf-8" })

  #       @event = ACTV.event('valid_event')
  #     end

  #     it "should return false if now is not between sales_start_date and sales_end_date" do
  #       @event.registration_open?.should be_false
  #     end

  #     it "should return true if now is between sales_start_date and sales_end_date" do
  #       today = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
  #       tomorrow = (Time.now + (24*60*60)).strftime('%Y-%m-%dT%H:%M:%S')

  #       @event.stub(:sales_start_date).and_return(today)
  #       @event.stub(:sales_end_date).and_return(tomorrow)

  #       @event.registration_open?.should be_true
  #     end

  #     it "should return true if now is before sales_end_date and there is no sales_start_date" do
  #       tomorrow = (Time.now + (24*60*60)).strftime('%Y-%m-%dT%H:%M:%S')

  #       @event.stub(:sales_start_date).and_return(nil)
  #       @event.stub(:sales_end_date).and_return(tomorrow)

  #       @event.registration_open?.should be_true
  #     end

  #     it "should return true if now is before start_date and there isn't a sales_start_date or sales_end_date" do
  #       tomorrow = (Time.now + (24*60*60)).strftime('%Y-%m-%dT%H:%M:%S')

  #       @event.stub(:sales_start_date).and_return(nil)
  #       @event.stub(:sales_end_date).and_return(nil)
  #       @event.stub(:start_date).and_return(tomorrow)

  #       @event.registration_open?.should be_true
  #     end
  #   end
  # end

  # context 'when registration has ended' do

  #   before(:each) do
  #     stub_get("/v2/assets/valid_event.json").
  #       to_return(body: fixture("valid_event.json"), headers: { content_type: "application/json; charset=utf-8" })
  #     @event = ACTV.event('valid_event')
  #   end

  #   it "should return true if start date and end date are different and end date has passed" do
  #     @event.ended?.should be_true
  #   end

  #   it "should return false if start date and end date are different and end date has not passed" do
  #     today = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
  #     tomorrow = (Time.now + (24*60*60)).strftime('%Y-%m-%dT%H:%M:%S')

  #     @event.stub(:start_date).and_return(today)
  #     @event.stub(:end_date).and_return(tomorrow)

  #     @event.ended?.should be_false
  #   end

  #   it "should return false if today is the event date of a one day event" do
  #     today = Time.now.strftime('%Y-%m-%dT%H:%M:%S')

  #     @event.stub(:start_date).and_return(today)
  #     @event.stub(:end_date).and_return(today)

  #     @event.ended?.should be_false
  #   end

  # end
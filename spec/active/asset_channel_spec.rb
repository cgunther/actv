require 'spec_helper'

describe ACTV::AssetChannel do

  describe "#channel" do
    it "returns a Channel when channel is set" do
      channel = ACTV::AssetChannel.new(sequence: "1", channel: { channelId: "1", channelName: "Channel", channelDsc: "Channel" }).channel
      channel.should be_a ACTV::Channel
    end

    it "returns nil when channel is not set" do
      channel = ACTV::AssetChannel.new(sequence: "1").channel
      channel.should be_nil
    end
  end

end
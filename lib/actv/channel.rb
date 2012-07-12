require 'actv/identity'

module ACTV
  class Channel < ACTV::Identity

    attr_reader :channelId, :channelName, :channelDsc

    alias id channelId
    alias name channelName
    alias description channelDsc

  end
end
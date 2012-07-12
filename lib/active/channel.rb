require 'active/identity'

module Active
  class Channel < Active::Identity

    attr_reader :channelId, :channelName, :channelDsc

    alias id channelId
    alias name channelName
    alias description channelDsc

  end
end
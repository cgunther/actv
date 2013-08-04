require 'actv/channel'

module ACTV
  class AssetChannel < Base

    attr_reader :sequence

    def channel
      @channel ||= ACTV::Channel.fetch_or_create(@attrs[:channel]) unless @attrs[:channel].nil?
    end

  end
end
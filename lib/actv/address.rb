require 'actv/identity'

module ACTV
  class Address < ACTV::Identity

    attr_reader :city, :country_code, :line1, :line2, :postal_code, :province

    # alias id channelId
    # alias name channelName
    # alias description channelDsc

  end
end
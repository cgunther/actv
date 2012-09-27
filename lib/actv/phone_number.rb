require 'actv/identity'

module ACTV
  class PhoneNumber < ACTV::Base

    attr_reader :number, :sms_capable, :status, :verified, :id

  end
end
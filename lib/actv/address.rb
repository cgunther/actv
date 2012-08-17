require 'actv/identity'

module ACTV
  class Address < ACTV::Base

    attr_reader :city, :country_code, :line1, :line2, :postal_code, :province

  end
end
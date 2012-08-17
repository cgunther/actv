require 'actv/address'

module ACTV
  class User < ACTV::Identity

    attr_reader :first_name, :last_name, :middle_name, :gender, :display_name, :dob

    alias date_of_birth dob
    
    def address
      @address ||= ACTV::Address.fetch_or_new(@attrs[:address]) unless @attrs[:address].nil?
    end
    
  end
end
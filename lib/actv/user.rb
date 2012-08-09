module ACTV
  class User < ACTV::Identity

    attr_reader :first_name, :last_name, :middle_name, :gender, :display_name, :dob

    alias date_of_birth dob
  end
end
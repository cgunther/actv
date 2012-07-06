require 'active/identity'

module Active
  class Asset < Active::Identity

    attr_reader :title, :description, :start_date, :address, :zip
  end
end
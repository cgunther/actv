require 'faraday'
require 'active/configurable'
module Active
  # Wrapper for the Active REST API
  #
  # @note
  class Client
    include Active::Configurable
    
    # Initialized a new Client object
    # 
    # @param options [Hash]
    # @return[Active::Client]
    def initialize(options={})
      Active::Configurable.keys.each do |key|
        instance_variable_set("@#{key}", options[key] || Active.options[key])
      end
    end
    
    
  end
end
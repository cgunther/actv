require "active/client"
require "active/configurable"
require "active/default"

module Active
  class << self
    include Active::Configurable

    # Delegate to a Active::Client
    #
    # @return [Active::Client]
    def client
      Active::Client.new(options)
    end
    
    def options
      @options = {}
      Active::Configurable.keys.each do |key|
        @options[key] = instance_variable_get("@#{key}")
      end
      
      @options
    end

    def respond_to?(method, include_private=false)
      self.client.respond_to?(method, include_private) || super
    end
    
    def reset!
      Active::Configurable.keys.each do |key|
        instance_variable_set("@#{key}", Active::Default.options[key])
      end
      self
    end
    alias setup reset!

  private

    def method_missing(method, *args, &block)
      return super unless self.client.respond_to?(method)
      self.client.send(method, *args, &block)
    end

  end
end

Active.setup
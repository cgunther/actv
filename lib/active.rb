require "active/version"
require "active/client"
require "active/configurable"
require "active/default"
require "active/base"

module Active
  class << self
    include Active::Configurable
    
    def options
      @options = {}
      Active::Configurable.keys.each do |key|
        @options[key] = instance_variable_get("@#{key}")
      end
      
      @options
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
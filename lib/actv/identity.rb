require 'actv/base'

module ACTV
  class Identity < Base

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing an :id key.
    # @return [ACTV::Base]
    def initialize(attrs={})
      self.update(attrs)

      if self.id
        @@identity_map[self.class] ||= {}
        @@identity_map[self.class][self.id] = self
      else
        raise ArgumentError, "argument must have an :id key"
      end
    end

    # @param other [ACTV::Identity]
    # @return [Boolean]
    def ==(other)
      super || self.attr_equal(:id, other) || self.attrs_equal(other)
    end

    # @return [Integer]
    def id
      @attrs[:id]
    end

  end
end
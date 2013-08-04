require 'actv/base'

module ACTV
  class Identity < Base

    def self.fetch(attrs)
      return unless ACTV.identity_map

      id = attrs[:id]
      ACTV.identity_map[self] ||= {}

      if id && ACTV.identity_map[self][id]
        return ACTV.identity_map[self][id].update(attrs)
      end

      return yield if block_given?
      raise ACTV::IdentityMapKeyError, 'key not found'
    end

    def self.store(object)
      ACTV.identity_map[self] ||= {}
      object.id && ACTV.identity_map[self][object.id] = object || super(object)
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing an :id key.
    # @return [ACTV::Base]
    def initialize(attrs={})
      self.update(attrs)
      raise ArgumentError, "argument must have an :id key" unless self.id
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
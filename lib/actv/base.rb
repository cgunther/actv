module ACTV
  class Base
    attr_reader :attrs
    alias body attrs

    # Define methods that retrieve the value from an initialized instance variable Hash, using the attribute as a key
    #
    # @overload self.    attr_reader(attr)
    #   @param attr [Symbol]
    # @overload self.    attr_reader(attrs)
    #   @param attrs [Array<Symbol>]
    def self.attr_reader(*attrs)
      attrs.each do |attribute|
        class_eval do
          define_method attribute do
            @attrs[attribute.to_sym]
          end
        end
      end
    end

    def self.fetch(attrs)
      return unless ACTV.identity_map

      ACTV.identity_map[self] ||= {}
      if object = ACTV.identity_map[self][Marshal.dump(attrs)]
        return object
      end

      return yield if block_given?
      raise ACTV::IdentityMapKeyError, 'key not found'
    end

    def self.store(object)
      return object unless ACTV.identity_map

      ACTV.identity_map[self] ||= {}
      ACTV.identity_map[self][Marshal.dump(object.attrs)] = object
    end

    def self.from_response(response={})
      self.fetch_or_new(response[:body])
    end

    def self.fetch_or_new(attrs={})
      return self.new(attrs) unless ACTV.identity_map

      self.fetch(attrs) do
        object = self.new(attrs)
        self.store(object)
      end
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @return [ACTV::Base]
    def initialize(attrs={})
      self.update(attrs)
    end

    # Fetches an attribute of an object using hash notation
    #
    # @param method [String, Symbol] Message to send to the object
    def [](method)
      self.send(method.to_sym)
    rescue NoMethodError
      nil
    end

    # Update the attributes of an object
    #
    # @param attrs [Hash]
    # @return [ACTV::Base]
    def update(attrs)
      @attrs ||= {}
      @attrs.update(attrs)
      self
    end

    def method_missing(meth, *args, &block)
      if @attrs && @attrs.has_key?(meth)
        @attrs[meth]
      elsif meth.to_s.include?('=') and !args.empty?
        @attrs[meth[0..-2].to_sym] = args.first
      else
        super
      end
    end

    def respond_to?(meth, *args)
      if @attrs && @attrs.has_key?(meth)
        true
      else
        super
      end
    end

    # Creation of object hash when sending request to soap
    def to_hash
      hash = {}
      hash["attrs"] = @attrs

      self.instance_variables.keep_if { |key| key != :@attrs }.each do |var|
        val = self.instance_variable_get(var)
        hash["attrs"][var.to_s.delete("@").to_sym] = val.to_hash if val.is_a? ACTV::Base
      end

      hash["attrs"]
    end

  protected

    # @param attr [Symbol]
    # @param other [ACTV::Base]
    # @return [Boolean]
    def attr_equal(attr, other)
      self.class == other.class && !other.send(attr).nil? && self.send(attr) == other.send(attr)
    end

    # @param other [ACTV::Base]
    # @return [Boolean]
    def attrs_equal(other)
      self.class == other.class && !other.attrs.empty? && self.attrs == other.attrs
    end

  end
end
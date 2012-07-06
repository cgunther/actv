require 'faraday'
require 'active/configurable'
require 'active/error/forbidden'
require 'active/error/not_found'
require 'simple_oauth'

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
    
    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end
    
    # Perform an HTTP Request
    def request(method, path, params, options)
      uri = options[:endpoint] || @endpoint
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path
      request_headers = {}
      if self.credentials?
        # When posting a file, don't sign any params
        signature_params = if [:post, :put].include?(method.to_sym) && params.values.any?{|value| value.is_a?(File) || (value.is_a?(Hash) && (value[:io].is_a?(IO) || value[:io].is_a?(StringIO)))}
          {}
        else
          params
        end
        authorization = SimpleOAuth::Header.new(method, uri, signature_params, credentials)
        request_headers[:authorization] = authorization.to_s
      end
      connection.url_prefix = options[:endpoint] || @endpoint
      connection.run_request(method.to_sym, path, nil, request_headers) do |request|
        unless params.empty?
          case request.method
          when :post, :put
            request.body = params
          else
            request.params.update(params)
          end
        end
        yield request if block_given?
      end.env
    rescue Faraday::Error::ClientError
      raise Active::Error::ClientError
    end
    
    # Check whether credentials are present
    #
    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end
    
  private
    
    # Credentials hash
    #
    # @return [Hash]
    def credentials
      {
        :consumer_key => @consumer_key,
        :consumer_secret => @consumer_secret,
        :token => @oauth_token,
        :token_secret => @oauth_token_secret,
      }
    end
    
  end
end
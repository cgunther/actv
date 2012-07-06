require 'faraday'
require 'active/configurable'
require 'active/request/multipart_with_file'
require 'active/response/parse_json'
require 'active/response/raise_client_error'
require 'active/response/raise_server_error'
# require 'twitter/response/rate_limit'
require 'active/version'

module Active
  module Default
    class << self

      def options
        Hash[Active::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @note This is configurable in case you want to use HTTP instead of HTTPS or use a Active-compatible endpoint.
      # @see http://en.blog.wordpress.com/2009/12/12/twitter-api/
      # @see http://staff.tumblr.com/post/287703110/api
      # @see http://developer.typepad.com/typepad-twitter-api/twitter-api.html
      def endpoint
        @endpoint ||= 'https://api.active.com'
      end

      def media_endpoint
        @media_endpoint ||= 'https://upload.active.com'
      end

      def search_endpoint
        @search_endpoint ||= 'https://search.active.com'
      end

      def connection_options
        @connection_options ||= {
          :headers => {
            :accept => 'application/json',
            :user_agent => "Active Ruby Gem #{Active::VERSION}"
          },
          :open_timeout => 5,
          :raw => true,
          :ssl => {:verify => false},
          :timeout => 10,
        }
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      def middleware
        @middleware ||= Faraday::Builder.new(
          &Proc.new do |builder|
            builder.use Active::Request::MultipartWithFile # Convert file uploads to Faraday::UploadIO objects
            builder.use Faraday::Request::Multipart         # Checks for files in the payload
            builder.use Faraday::Request::UrlEncoded        # Convert request params as "www-form-urlencoded"
            # builder.use Active::Response::RaiseClientError # Handle 4xx server responses
            # builder.use Active::Response::ParseJson        # Parse JSON response bodies using MultiJson
            builder.use Active::Response::RaiseServerError # Handle 5xx server responses
            # builder.use Active::Response::RateLimit        # Update RateLimit object
            builder.adapter Faraday.default_adapter         # Set Faraday's HTTP adapter
          end
        )
      end

      def consumer_key
        ENV['ACTIVE_CONSUMER_KEY']
      end

      def consumer_secret
        ENV['ACTIVE_CONSUMER_SECRET']
      end

      def oauth_token
        ENV['ACTIVE_OAUTH_TOKEN']
      end

      def oauth_token_secret
        ENV['ACTIVE_OAUTH_TOKEN_SECRET']
      end

    end
  end
end

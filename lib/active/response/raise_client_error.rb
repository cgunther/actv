require 'faraday'
require 'active/error/bad_request'
require 'active/error/enhance_your_calm'
require 'active/error/forbidden'
require 'active/error/not_acceptable'
require 'active/error/not_found'
require 'active/error/unauthorized'

module Active
  module Response
    class RaiseClientError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = Active::Error::ClientError.errors[status_code]
        raise error_class.from_response_body(env[:body]) if error_class
      end

    end
  end
end

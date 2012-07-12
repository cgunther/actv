require 'faraday'
require 'actv/error/bad_request'
require 'actv/error/enhance_your_calm'
require 'actv/error/forbidden'
require 'actv/error/not_acceptable'
require 'actv/error/not_found'
require 'actv/error/unauthorized'

module ACTV
  module Response
    class RaiseClientError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = ACTV::Error::ClientError.errors[status_code]
        raise error_class.from_response_body(env[:body]) if error_class
      end

    end
  end
end

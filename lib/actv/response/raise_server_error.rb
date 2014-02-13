require 'faraday'
require 'actv/error/bad_gateway'
require 'actv/error/gateway_timeout'
require 'actv/error/internal_server_error'
require 'actv/error/service_not_found'
require 'actv/error/service_unavailable'

module ACTV
  module Response
    class RaiseServerError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = ACTV::Error::ServerError.errors[status_code]
        raise error_class.new if error_class
      end

    end
  end
end

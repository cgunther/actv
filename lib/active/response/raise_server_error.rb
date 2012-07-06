require 'faraday'
require 'active/error/bad_gateway'
require 'active/error/internal_server_error'
require 'active/error/service_unavailable'

module Active
  module Response
    class RaiseServerError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = Active::Error::ServerError.errors[status_code]
        raise error_class.new if error_class
      end

    end
  end
end

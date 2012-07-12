require 'actv/error/server_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 502
    class BadGateway < ACTV::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "Twitter is down or being upgraded."
    end
  end
end

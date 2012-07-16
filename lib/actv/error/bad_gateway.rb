require 'actv/error/server_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 502
    class BadGateway < ACTV::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "A3PI, or something it depends on (like Asset Service) is down."
    end
  end
end

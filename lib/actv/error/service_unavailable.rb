require 'actv/error/server_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 503
    class ServiceUnavailable < ACTV::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "(__-){ Active is over capacity."
    end
  end
end

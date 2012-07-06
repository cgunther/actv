require 'active/error/server_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 503
    class ServiceUnavailable < Active::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "(__-){ Active is over capacity."
    end
  end
end

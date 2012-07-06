require 'active/error/client_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 401
    class Unauthorized < Active::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end

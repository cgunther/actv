require 'active/error/client_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 404
    class NotFound < Active::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end

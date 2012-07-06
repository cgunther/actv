require 'active/error/client_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 400
    class BadRequest < Active::Error::ClientError
      HTTP_STATUS_CODE = 400
    end
  end
end

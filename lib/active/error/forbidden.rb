require 'active/error/client_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 403
    class Forbidden < Active::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end

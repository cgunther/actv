require 'active/error/client_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 406
    class NotAcceptable < Active::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end

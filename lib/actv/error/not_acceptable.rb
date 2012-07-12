require 'actv/error/client_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 406
    class NotAcceptable < ACTV::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end

require 'actv/error/client_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 404
    class NotFound < ACTV::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end

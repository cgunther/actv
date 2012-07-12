require 'actv/error/client_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 400
    class BadRequest < ACTV::Error::ClientError
      HTTP_STATUS_CODE = 400
    end
  end
end

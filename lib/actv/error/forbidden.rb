require 'actv/error/client_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 403
    class Forbidden < ACTV::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end

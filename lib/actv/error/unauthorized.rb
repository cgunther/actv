require 'actv/error/client_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 401
    class Unauthorized < ACTV::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end

require 'actv/error/client_error'

module ACTV
  class Error
    # Raised when Active returns the HTTP status code 420
    class EnhanceYourCalm < ACTV::Error::ClientError
      HTTP_STATUS_CODE = 420
    end
  end
end

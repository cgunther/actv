require 'active/error/client_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 420
    class EnhanceYourCalm < Active::Error::ClientError
      HTTP_STATUS_CODE = 420
    end
  end
end

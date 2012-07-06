require 'active/error/server_error'

module Active
  class Error
    # Raised when Active returns the HTTP status code 500
    class InternalServerError < Active::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end

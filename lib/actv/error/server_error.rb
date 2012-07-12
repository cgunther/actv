require 'actv/error'

module ACTV
  class Error
    # Raised when Active returns a 5xx HTTP status code
    class ServerError < ACTV::Error
      MESSAGE = "Server Error"

      # Initializes a new ServerError object
      #
      # @param message [String]
      # @return [Twitter::Error::ServerError]
      def initialize(message=nil)
        super(message || self.class.const_get(:MESSAGE))
      end

    end
  end
end
require 'actv/error'

module ACTV
  class Error
    # Raised when Active returns a 4xx HTTP status code or there's an error in Faraday
    class ClientError < ACTV::Error

      # Create a new error from an HTTP environment
      #
      # @param body [Hash]
      # @return [ACTV::Error]
      def self.from_response_body(body)
        new(parse_error(body))
      end

    private

      def self.parse_error(body)
        if body.nil?
          ''
        elsif body[:error]
          if body[:error][:message]
            body[:error][:message]
          else
            body[:error]
          end
        elsif body[:errors]
          first = Array(body[:errors]).first
          if first.kind_of?(Hash)
            first[:message].chomp
          else
            first.chomp
          end
        end
      end

    end
  end
end

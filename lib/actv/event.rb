require 'actv/asset'

module ACTV
  class Event < ACTV::Asset
    attr_reader :salesStartDate, :salesEndDate

    alias sales_start_date salesStartDate
    alias sales_end_date salesEndDate

    def online_registration_available?
      @online_registration ||= self.legacy_data.onlineRegistration.downcase == 'true'
    end
    alias online_registration? online_registration_available?

    def registration_not_yet_open?
      @reg_not_open ||= begin
        if online_registration_available?
          if self.sales_start_date
            return true if now_in_utc < utc_time(self.sales_start_date)
          end
        end

        false
      end
    end
    alias registration_not_open? registration_not_yet_open?
    alias reg_not_open? registration_not_yet_open?

    def registration_open?
      @reg_open ||= begin
        if online_registration_available?
          if self.sales_start_date
            if now_in_utc > utc_time(self.sales_start_date) and
              now_in_utc < utc_time(self.sales_end_date)
              return true
            end
          elsif now_in_utc < utc_time(self.start_date)
            return true
          end
        end

        false
      end
    end
    alias reg_open? registration_open?

    def registration_closed?
      @reg_closed ||= begin
        if online_registration_available?
          if self.sales_end_date
            if now_in_utc > utc_time(self.sales_end_date) and
              now_in_utc < utc_time(self.end_date)
              return true
            end
          elsif now_in_utc < utc_time(self.end_date)
            return true
          end
        end

        false
      end
    end
    alias reg_closed? registration_closed?

    def ended?
      return true if now_in_utc > utc_time(self.end_date)
    end

    def registration_opening_soon?(time_in_days=2)
      @reg_open_soon ||= begin
        if online_registration_available?
          if self.sales_start_date
            if now_in_utc >= utc_time(self.sales_start_date) - time_in_days.days and
              now_in_utc < utc_time(self.sales_start_date)
              return true
            end
          elsif now_in_utc >= utc_time(self.start_date) - time_in_days.days and
            now_in_utc < utc_time(self.start_date)
            return true
          end
        end

        false
      end
    end

    def registration_closing_soon?(time_in_days=2)
      @reg_closing_soon ||= begin
        if online_registration_available?
          if self.sales_end_date
            if now_in_utc >= utc_time(self.sales_end_date) - time_in_days.days and
              now_in_utc < utc_time(self.end_date)
              return true
            end
          elsif now_in_utc >= utc_time(self.end_date) - time_in_days.days and
            now_in_utc < utc_time(self.end_date)
            return true
          end
        end

        false
      end
    end

  private

    def now_in_utc
      Time.now.utc
    end

    def utc_time(time_string)
      return nil if time_string.nil? or time_string.empty?
      return Time.parse(time_string).utc
    end

  end
end



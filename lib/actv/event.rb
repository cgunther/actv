require 'actv/asset'

module ACTV
  class Event < ACTV::Asset
    attr_reader :salesStartDate, :salesEndDate, :activityStartDate, :activityEndDate
    alias sales_start_date salesStartDate
    alias sales_end_date salesEndDate
    alias activity_start_date activityStartDate
    alias activity_end_date activityEndDate

    def online_registration_available?
      self.legacy_data.onlineRegistration.downcase == 'true'
    end

    def registration_open?
      if online_registration_available?
        is_now_between? authoritative_reg_start_date, authoritative_reg_end_date
      else
        false
      end
    end

    def registration_closed?
      if online_registration_available?
        is_now_after? authoritative_reg_end_date
      else
        false
      end
    end

    def registration_not_yet_open?
      if online_registration_available?
        is_now_before? authoritative_reg_start_date
      else
        false
      end
    end

    def event_ended?
      event_end_date = self.end_date
      if self.start_date == event_end_date
        event_end_date = "#{event_end_date.split('T').first}T23:59:59"
      end
      is_now_after? event_end_date
    end

    def registration_opening_soon?(time_in_days=3)
      @reg_open_soon ||= begin
        if online_registration_available?
          if self.sales_start_date
            if now_in_utc >= utc_time(self.sales_start_date) - time_in_days.days and
              now_in_utc < utc_time(self.sales_start_date)
              return true
            end
          end
        end

        false
      end
    end

    def registration_closing_soon?(time_in_days=3)
      @reg_closing_soon ||= begin
        if online_registration_available?
          if self.sales_end_date
            if now_in_utc >= utc_time(self.sales_end_date) - time_in_days.days and
              now_in_utc < utc_time(self.end_date)
              return true
            end
          end
        end

        false
      end
    end

    def image_url
      defaultImage = 'http://www.active.com/images/events/hotrace.gif'
      image = ''

      self.assetImages.each do |i|
        if i.imageUrlAdr.downcase != defaultImage
          image = i.imageUrlAdr
          break
        end
      end

      if image.blank?
        if (self.logoUrlAdr && self.logoUrlAdr != defaultImage && self.logoUrlAdr =~ URI::regexp)
          image = self.logoUrlAdr
        end
      end
      image
    end

    alias online_registration? online_registration_available?
    alias reg_open? registration_open?
    alias reg_closed? registration_closed?
    alias registration_not_open? registration_not_yet_open?
    alias reg_not_open? registration_not_yet_open?
    alias reg_not_yet_open? registration_not_yet_open?
    alias ended? event_ended?

    private

    def authoritative_reg_end_date
      if is_present? sales_end_date
        sales_end_date
      elsif is_present? activity_end_date
        activity_end_date
      elsif is_present? activity_start_date
        activity_start_date
      else
        "9999-12-31T23:59:59"
      end
    end

    def authoritative_reg_start_date
      if is_present? sales_start_date
        sales_start_date
      else
        "0000-01-01T00:00:00"
      end
    end

    def is_now_before? date_string
      now_in_utc < utc_time(date_string)
    end

    def is_now_after? date_string
      !is_now_before? date_string
    end

    def is_now_between? start_date_string, end_date_string
      utc_time(start_date_string) < now_in_utc && now_in_utc < utc_time(end_date_string)
    end

    def is_present? obj
      !obj.nil? && !obj.empty?
    end

    def now_in_utc
      Time.now.utc
    end

    def utc_time(time_string)
      return nil if time_string.nil? or time_string.empty?
      return Time.parse(time_string).utc
    end

  end
end



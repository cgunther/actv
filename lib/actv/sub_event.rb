module ACTV
  class SubEvent
    attr_accessor :id, :name, :start_date, :end_date, :url

    def initialize hsh
      @id = hsh[:assetGuid]
      @name = hsh[:assetName]
      @start_date = Time.parse(hsh.fetch(:activityStartDate, "1970-01-01T00:00:00"))
      @end_date = Time.parse(hsh.fetch(:activityEndDate, "1970-01-01T00:00:00"))
      url = hsh.fetch(:assetSeoUrls, []).first || {}
      @url = url.fetch :urlAdr, "http://www.active.com/asset_service/#{@id}"
    end
  end
end


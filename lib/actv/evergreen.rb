module ACTV
  class Evergreen < SimpleDelegator
    attr_accessor :asset, :current_event, :events
    def initialize asset
      super asset
      @events = []
      @current_event = {}
      asset.evergreenAssets.each do |sub_asset|
        @events << sub_asset
        @current_event = sub_asset if Time.parse(sub_asset.fetch(:activityEndDate, "1970-01-01T00:00:01")) > Time.parse(@current_event.fetch(:activityEndDate, "1970-01-01T00:00:01"))
      end
      @current_event = ACTV.event @current_event[:assetGuid]

      self
    end

    def method_missing method, *args, &block
      @current_event.send method, *args
    end
  end
end

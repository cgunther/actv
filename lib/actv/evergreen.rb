require 'delegate'

module ACTV
  class Evergreen < ::SimpleDelegator
    attr_accessor :asset, :current_event, :events

    def initialize asset
      super asset
      @asset = asset
      @events = []
      @current_event = {}
      asset.evergreenAssets.each do |sub_asset|
        @events << SubEvent.new(sub_asset)
      end
      @events = @events.sort_by { |event| event.end_date }.reverse
      @current_event = @events.first
      @current_event = ACTV.event @current_event[:assetGuid]

      self
    end

    def evergreen?
      true
    end

    def components
      @current_event.components
    end

    def legacy_data
      @current_event.legacy_data
    end

    def description_by_type type
      asset_description = @asset.description_by_type type rescue nil

      if asset_description.present?
        asset_description
      else
        @current_event.description_by_type type
      end
    end

    def method_missing method, *args, &block
      begin
        @asset.send(method, *args)
      rescue NoMethodError => e
        @current_event.send(method, *args)
      end
    end
  end
end


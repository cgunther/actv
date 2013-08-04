require 'actv/asset_description_type'

module ACTV
  class AssetDescription < Base

    attr_reader :description

    def type
        @description_type ||= ACTV::AssetDescriptionType.fetch_or_new(@attrs[:descriptionType]) unless @attrs[:descriptionType].nil?
    end
    alias description_type type
    alias descriptionType type

  end
end
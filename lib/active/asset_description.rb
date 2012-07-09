require 'active/identity'
require 'active/asset_description_type'

module Active
  class AssetDescription < Base

    attr_reader :description

    def description_type
        @description_type ||= Active::AssetDescriptionType.fetch_or_new(@attrs[:descriptionType]) unless @attrs[:descriptionType].nil?
    end

  end
end
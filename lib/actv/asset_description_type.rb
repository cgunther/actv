require 'actv/identity'

module ACTV
  class AssetDescriptionType < ACTV::Identity

    attr_reader :descriptionTypeId, :descriptionTypeName

    alias id descriptionTypeId
    alias name descriptionTypeName

  end
end
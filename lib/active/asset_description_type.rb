require 'active/identity'

module Active
  class AssetDescriptionType < Active::Identity

    attr_reader :descriptionTypeId, :descriptionTypeName

    alias id descriptionTypeId
    alias name descriptionTypeName

  end
end
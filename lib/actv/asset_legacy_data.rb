require 'actv/identity'

module ACTV
  class AssetLegacyData < Base

    attr_reader :assetTypeId, :typeName, :onlineRegistration, :seoUrl, 
      :substitutionUrl, :isSearchable, :createdDate, :modifiedDate

    alias id assetTypeId
    alias type_name typeName
    alias online_registration? onlineRegistration
    alias online_registration onlineRegistration
    alias seo_url seoUrl
    alias substitution_url substitutionUrl
    alias is_searchable? isSearchable
    alias created_at createdDate
    alias updated_at modifiedDate

  end
end
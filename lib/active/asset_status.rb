require 'active/identity'

module Active
  class AssetStatus < Active::Identity

    attr_reader :assetStatusId, :assetStatusName, :isSearchable, :isDeleted,
      :createdDate, :modifiedDate

    alias id assetStatusId
    alias name assetStatusName
    alias is_searchable? isSearchable
    alias is_deleted? isDeleted
    alias created_at createdDate
    alias updated_at modifiedDate

  end
end
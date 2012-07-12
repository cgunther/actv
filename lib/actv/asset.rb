require 'actv/asset_description'
require 'actv/asset_legacy_data'
require 'actv/asset_status'
require 'actv/identity'
require 'actv/place'

module ACTV
  class Asset < ACTV::Identity

    attr_reader :assetGuid, :assetName, :assetDsc, :activityStartDate, :activityStartTime, :activityEndDate, :activityEndTime,
      :homePageUrlAdr, :isRecurring, :contactName, :contactEmailAdr, :contactPhone, :showContact, :createdDate, :modifiedDate

    alias id assetGuid
    alias title assetName
    alias description assetDsc
    alias start_date activityStartDate
    alias start_time activityStartTime
    alias end_date activityEndDate
    alias end_time activityEndTime
    alias home_page_url homePageUrlAdr
    alias is_recurring? isRecurring
    alias contact_name contactName
    alias contact_email contactEmailAdr
    alias contact_phone contactPhone
    alias show_contact? showContact
    alias create_at createdDate
    alias updated_at modifiedDate

    def place
      @place ||= ACTV::Place.fetch_or_new(@attrs[:place]) unless @attrs[:place].nil?
    end

    def descriptions
      @descriptions ||= Array(@attrs[:assetDescriptions]).map do |description|
        ACTV::AssetDescription.fetch_or_new(description)
      end
    end
    alias assetDescriptions descriptions

    def status
      @status ||= ACTV::AssetStatus.fetch_or_new(@attrs[:assetStatus]) unless @attrs[:assetStatus].nil?
    end

    def legacy_data
      @legacy_data ||= ACTV::AssetLegacyData.fetch_or_new(@attrs[:assetLegacyData]) unless @attrs[:assetLegacyData].nil?
    end

  end
end
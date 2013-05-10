require 'actv/asset_channel'
require 'actv/asset_component'
require 'actv/asset_description'
require 'actv/asset_image'
require 'actv/asset_legacy_data'
require 'actv/asset_price'
require 'actv/asset_status'
require 'actv/asset_tag'
require 'actv/asset_topic'
require 'actv/asset_seo_url'
require 'actv/identity'
require 'actv/place'

module ACTV
  class Asset < ACTV::Identity

    attr_reader :assetGuid, :assetName, :assetDsc, :activityStartDate, :activityStartTime, :activityEndDate, :activityEndTime,
      :homePageUrlAdr, :isRecurring, :contactName, :contactEmailAdr, :contactPhone, :showContact, :publishDate, :createdDate, :modifiedDate,
      :authorName, :is_event, :is_article

    alias id assetGuid
    alias title assetName
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
    alias published_at publishDate
    alias created_at createdDate
    alias updated_at modifiedDate
    alias author_name authorName

    def place
      @place ||= ACTV::Place.fetch_or_new(@attrs[:place]) unless @attrs[:place].nil?
    end

    def descriptions
      @descriptions ||= Array(@attrs[:assetDescriptions]).map do |description|
        ACTV::AssetDescription.fetch_or_new(description)
      end
    end
    alias asset_descriptions descriptions
    alias assetDescriptions descriptions

    def status
      @status ||= ACTV::AssetStatus.fetch_or_new(@attrs[:assetStatus]) unless @attrs[:assetStatus].nil?
    end
    alias asset_status status
    alias assetStatus status

    def legacy_data
      @legacy_data ||= ACTV::AssetLegacyData.fetch_or_new(@attrs[:assetLegacyData]) unless @attrs[:assetLegacyData].nil?
    end
    alias asset_legacy_data legacy_data
    alias assetLegacyData legacy_data

    def channels
      @asset_channels ||= Array(@attrs[:assetChannels]).map do |channel|
        ACTV::AssetChannel.fetch_or_new(channel)
      end
    end
    alias asset_channels channels
    alias assetChannels channels

    def images
      @images ||= Array(@attrs[:assetImages]).map do |img|
        ACTV::AssetImage.fetch_or_new(img)
      end
    end
    alias asset_images images
    alias assetImages images

    def tags
      @asset_tags ||= Array(@attrs[:assetTags]).map do |tag|
        ACTV::AssetTag.fetch_or_new(tag)
      end
    end
    alias asset_tags tags
    alias assetTags tags

    def components
      @asset_components ||= Array(@attrs[:assetComponents]).map do |component|
        ACTV::AssetComponent.fetch_or_new(component)
      end
    end
    alias asset_components components
    alias assetComponents components

    def prices
      @asset_prices ||= Array(@attrs[:assetPrices]).map do |price|
        ACTV::AssetPrice.fetch_or_new(price)
      end
    end
    alias asset_prices prices
    alias assetPrices prices

    def topics
      @asset_topics ||= Array(@attrs[:assetTopics]).map do |topic|
        ACTV::AssetTopic.fetch_or_new(topic)
      end
    end
    alias asset_topics topics
    alias assetTopics topics

    def seo_urls
      @seo_urls ||= Array(@attrs[:assetSeoUrls]).map do |seo_url|
        ACTV::AssetSeoUrl.fetch_or_new(seo_url)
      end
    end
    alias asset_seo_urls seo_urls
    alias assetSeoUrls seo_urls

    def summary
      @summary ||= description_by_type 'summary'
    end

    def description
      @description ||= description_by_type 'Standard'
    end

    def seo_url(systemName = 'as3')
      seo_url = self.seo_urls.find { |s| s.seoSystemName.downcase == systemName.downcase }
      seo_url.urlAdr unless seo_url.nil?
    end

    def description_by_type(type)
      dsc = self.descriptions.find { |dsc| dsc.type.name.downcase == type.downcase }
      (dsc.description.downcase == 'n/a' ? '' : dsc.description) if dsc
    end
    def image_by_name(name)
      self.images.find { |img| img.name.downcase == name.downcase }
    end

    def tag_by_description(description)
      asset_tag = self.tags.find { |at| at.tag.description.downcase == description.downcase }
      asset_tag.tag.name if asset_tag
    end

    def is_event?
      self.assetCategories.each do |category|
        if category[:category][:categoryTaxonomy].downcase.start_with?('event')
          return true
        end
      end
      false
    end

    def is_article?
      is_article = false
      if self.assetCategories.any?
        self.assetCategories.each do |category|
          if category[:category][:categoryName].downcase == 'articles'
            is_article = true
          end
        end
      else
        # no categories so check the sourceSystem
        # this guid is equal to the Active.com Articles
        if self.sourceSystem.fetch(:legacyGuid, "").upcase == "CA4EA0B1-7377-470D-B20D-BF6BEA23F040"
          is_article = true
        end
      end

      is_article
    end

    def registration_status
      @registration_status ||= nil
    end
    alias reg_status registration_status
  end
end
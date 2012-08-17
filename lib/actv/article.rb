require 'actv/asset'

module ACTV
  class Article < ACTV::Asset
    def summary
      @summary ||= description_by_type 'summary'
    end

    def description
      @description ||= description_by_type 'Standard'
    end

    def by_line
      @author ||= description_by_type 'articleByLine'
    end

    def author_bio
      @author_bio ||= description_by_type 'articleAuthorBio'
    end

    def author_photo
      @author_photo ||= image_by_name 'authorImage'
    end

    def source
      @source ||= description_by_type 'articleSource'
    end

  private

    def description_by_type(type)
      dsc = self.descriptions.find { |dsc| dsc.type.name.downcase == type.downcase }
      dsc.description if dsc
    end

    def image_by_name(name)
      self.images.find { |img| img.name.downcase == name.downcase }
    end
  end
end
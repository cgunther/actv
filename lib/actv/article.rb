require 'actv/asset'

module ACTV
  class Article < ACTV::Asset
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

    def type
      @type ||= tag_by_description 'articleType'
    end

    def image
      @image ||= image_by_name 'image2'
    end

    def subtitle
      @subtitle ||= description_by_type 'subtitle'
    end

    def footer
      @footer ||= description_by_type 'footer'
    end

    def inline_ad
      @inline_ad ||= tag_by_description 'inlinead'
    end
    alias inline_ad? inline_ad
  end
end
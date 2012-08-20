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
  end
end
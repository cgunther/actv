module ACTV
  class AssetImage < Base

    attr_reader :imageUrlAdr, :imageName, :imageCaptionTxt

    alias url     imageUrlAdr
    alias name    imageName
    alias caption imageCaptionTxt

  end
end

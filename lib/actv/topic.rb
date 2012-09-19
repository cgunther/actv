module ACTV
  class Topic < Base
    attr_reader :topicId, :topicName, :topicTaxonomy

    alias id topicId
    alias name topicName
    alias taxonomy topicTaxonomy
  end
end
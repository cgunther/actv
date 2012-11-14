module ACTV
  class EventResult < Base

    attr_reader :id, :title, :date, :asset_type_id, :asset_id, :event_type, :latitude, :longitude, 
      :address, :url, :user, :sub_events
    
  end
end
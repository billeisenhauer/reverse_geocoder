module ReverseGeocoder
  
  @geocoder_order = [Google, Numerex, Geonames, GeoPlugin]
  class << self; attr_accessor :geocoder_order end
  
  # Multi Reverse Geocoder
  #     
  class Multi

    def self.geocode(lat, lng, options={})
      ReverseGeocoder::geocoder_order.each do |geocoder_class|
        begin
          return geocoder_class.send(:geocode, lat, lng, options)
        rescue
        end
      end
    end
      
  end
  
end
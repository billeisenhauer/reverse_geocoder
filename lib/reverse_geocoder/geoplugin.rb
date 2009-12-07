module ReverseGeocoder
  
  # GeoPlugin Reverse Geocoder
  #     
  class GeoPlugin
    include ReverseGeocoder::Geocoder
    
    base_uri 'http://www.geoplugin.net/extras'
    default_params :format => 'xml'
    
    private
    
      def self.request(lat, lng, options)
        query = {:lat => "#{lat}", :long => "#{lng}"}.merge(options)
        get("/location.gp", :query => query)
      end
      
      def self.normalize(response)
        results = {:geocoder => 'GeoPlugin'}
        address = response['geoPlugin']
        results[:address] = "#{address['geoplugin_place']}, #{address['geoplugin_regionAbbreviated']}, #{address['geoplugin_countryCode']}"
        results[:country_code] = address['geoplugin_countryCode']
        results[:country_name] = address['geoplugin_countryCode']
        results
      end
      
  end
  
end
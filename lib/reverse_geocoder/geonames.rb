module ReverseGeocoder
  
  # Geonames Reverse Geocoder
  #     
  class Geonames
    include ReverseGeocoder::Geocoder
    
    base_uri 'http://ws.geonames.org'
    
    private
    
      def self.request(lat, lng, options)
        query = {:lat => "#{lat}", :lng => "#{lng}"}.merge(options)
        get("/findNearestAddress", :query => query)
      end
      
      def self.normalize(response)
        results = {:geocoder => 'Geonames'}
        results[:address] = assemble_address_from(response)
        results[:country_code] = results[:country_name] = response['geonames']['address']['countryCode']
        results
      end
      
      def self.assemble_address_from(response)
        address = response['geonames']['address']
        str =  "#{address['placename']}, "
        str += "#{address['streetNumber']} #{address['street']}, "
        str += "#{address['adminName2']}, #{address['adminCode1']}, "
        str += "#{address['postalcode']}, "
        str += "#{address['countryCode']}"
      end
      
  end
  
end
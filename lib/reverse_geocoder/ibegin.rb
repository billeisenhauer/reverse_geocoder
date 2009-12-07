module ReverseGeocoder
  
  # iBegin Reverse Geocoder
  #     
  class IBegin
    include ReverseGeocoder::Geocoder
    
    class << self; attr_accessor :api_key end
    
    base_uri 'http://geocoder.ibegin.com'
    default_params :apikey => api_key
    
    private
    
      def self.request(lat, lng, options)
        query = {:latitude => "#{lat}", :longitude => "#{lng}"}.merge(options)
        get("/geoxml/", :query => query)
      end
      
      def self.normalize(response)
        results = {:geocoder => 'iBegin'}
        address = response['geocode']
        results[:address] = assemble_address_from(address)
        results[:country_code] = "US"
        results[:country_name] = "USA"
        results
      end
      
      def self.assemble_address_from(address)
        str =  "#{address['stnumber']} #{address['stname']}, "
        str += "#{address['stcity']}, #{address['ststate']}, "
        str += "#{address['stzip']}, US"
      end
      
  end
  
end
module ReverseGeocoder
  
  # Numerex Reverse Geocoder
  #     
  class Numerex
    include ReverseGeocoder::Geocoder
    
    base_uri 'http://geo.numerex.com/api/rest/'
    default_params :function => 'getAddress'
    
    private
    
      def self.request(lat, lng, options)
        query = {:lat => "#{lat}", :lon => "#{lng}"}.merge(options)
        get("/AddressFinder.php", :query => query)
      end
      
      def self.normalize(response)
        results = {:geocoder => 'Numerex'}
        address = response['address']
        results[:address] = assemble_address_from(address)
        results[:country_code] = ''
        results[:country_name] = ''
        results
      end
      
      def self.assemble_address_from(address)
        str =  address['addr_line1'] + ', '
        str += address['addr_line2']
      end
      
  end
  
end
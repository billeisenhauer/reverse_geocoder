module ReverseGeocoder
  
  # Google Reverse Geocoder
  #     
  class Google
    include ReverseGeocoder::Geocoder
    
    class << self; attr_accessor :api_key end
    
    base_uri 'http://maps.google.com/maps'
    
    private
    
      def self.request(lat, lng, options)
        query = {:q => "#{lat},#{lng}", :key => api_key}.merge(options)
        get("/geo", :query => query)
      end
      
      def self.normalize(response)
        handle_status(response['Status']['code'])
        results = {:geocoder => 'Google'}
        results[:address] = response['Placemark'][0]['address']
        results[:country_code] = response['Placemark'][0]['AddressDetails']['Country']['CountryNameCode']
        results[:country_name] = response['Placemark'][0]['AddressDetails']['Country']['CountryName']
        results
      end
      
      def self.handle_status(status)
        case status.to_i
          when 500 
            raise UnknownServiceError
          when 601 
            raise MalformedRequest
          when 602, 603
            raise UnavailableAddress
          when 610 
            raise AuthenticationError
          when 620 
            raise QueryLimitExceeded
        end
      end
      
      VALID_OPTIONS = [:sensor]
      
      def self.validate_geocoder_options(options)
        options.keys.each do |key|
          unless VALID_OPTIONS.include?(key)
            raise ArgumentError, "Options cannot include :#{key}"
          end
        end
      end
      
  end
  
end
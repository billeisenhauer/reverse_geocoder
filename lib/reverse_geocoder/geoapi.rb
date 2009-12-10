module ReverseGeocoder
  
  # GeoApi Reverse Geocoder
  #     
  class GeoApi
    include ReverseGeocoder::Geocoder
    
    class << self; attr_accessor :api_key end
    
    base_uri 'http://api.geoapi.com/v1'
    format :json
    
    private
    
      def self.request(lat, lng, options)
        query = {:lat => "#{lat}", :lon => "#{lng}", :apikey => api_key}.merge(options)
        get("/parents", :query => query)
      end
      
      def self.normalize(response)
        results = {:geocoder => 'GeoApi'}
        address = response['result']['parents']
        results[:address] = assemble_address_from(address)
        results[:country_code] = ''
        results[:country_name] = ''
        results
      end
      
      def self.assemble_address_from(address)
        names = []
        address.each do |parent_hash|
          names << parent_hash['meta']['name'] if parent_hash['meta']['type'] == 'user-entity'
        end
        names.inject('') {|longest_name, name| name if name.length > longest_name.length } 
      end
      
      VALID_OPTIONS = [:pretty]
      
      def self.validate_geocoder_options(options)
        options.keys.each do |key|
          unless VALID_OPTIONS.include?(key)
            raise ArgumentError, "Options cannot include :#{key}"
          end
        end
      end
      
  end
  
end
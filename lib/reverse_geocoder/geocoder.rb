module ReverseGeocoder    
  
  # This module is meant to be mixed in to a class to enable it to perform
  # reverse geocoding.  The including class needs to implement three hook
  # methods:
  # 
  # request(lat, lng, options)
  # normalize(response)
  # validate_geocoder_options(options)
  #
  # The request method uses HTTParty syntax to effect the service call and 
  # should return its reponse.  Exception handling is not required for the
  # HTTP response code.
  #
  # The normalize method takes the response parameter which behaves like a
  # Hash and maps it to an expected Hash structure.  As an alternative
  #
  # The validate_geocoder_options method is used to validate options provided
  # to a geocoder.  The geocoder can throw an exception or snuff out the 
  # options as needed.
  #
  module Geocoder   
    
    # Mix class methods into the base.
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, HTTParty)
    end
    
    module ClassMethods
    
      def geocode(lat, lng, options={})
        validate_coordinates(lat, lng)
        validate_options(options)
        process_request(lat, lng, options)
      end
      
      private
      
        ### HOOK METHODS ###
      
        # Perform the request from the web service.  This is the only required 
        # hook method.
        #
        def request(lat, lng, options)
        end

        # Normalize the hash response into a common response so responses are 
        # common between geocoders.  By default, return the non-normalized 
        # response if implementers don't wish to perform normalization.
        # 
        def normalize(response)
          response
        end
        
        # Used by geocoders to validate specific options.  If options are
        # found to be invalid, simply raise an ArgumentError.
        #
        def validate_geocoder_options(options)
        end
      
        ### VALIDATION ###
      
        def validate_coordinates(lat, lng)
          if lat.to_f < -90 || lat.to_f > 90
            raise ArgumentError, "Latitude #{lat} is invalid, try -90 to 90"
          end
          if lng.to_f < -180 || lng.to_f > 180
            raise ArgumentError, "Longitude #{lng} is invalid, try -180 to 180"
          end          
        end
      
        def validate_options(options)
          unless options.is_a?(Hash)
            raise ArgumentError, "Options should be Hash, but is a #{options.class.name}"
          end
          validate_geocoder_options(options)
        end
        
        ### REQUEST HANDLING ###
        
        def process_request(lat, lng, options={})
          response = request(lat, lng, options)
          handle_response(response)
        end
        
        def handle_response(response)
          case response.code.to_i
            when 200 
              normalize(response)
            when 401..403 
              raise AuthenticationError 
            when 404 
              raise UnavailableAddress
            else 
              raise UnknownServiceError
          end
        end
      
    end
  
  end
  
end
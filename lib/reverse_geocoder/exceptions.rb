module ReverseGeocoder
  
  # Exception raised when API key or service credentials are rejected
  class AuthenticationError < StandardError; end
  
  # Exception raised when query limits are exceeded for a service.
  class QueryLimitExceeded < StandardError; end
 
  # Exception raised when an unknown service error occurs.
  class UnknownServiceError < StandardError; end
 
  # Exception that is raised when an address is unknown or cannot be returned
  # for other reasons.
  class UnavailableAddress < StandardError; end
  
  # Exception that is raised when a service query is not understood by the 
  # service.
  class MalformedRequest < StandardError; end
  
end
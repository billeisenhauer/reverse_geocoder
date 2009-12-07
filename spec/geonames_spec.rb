require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Geonames Geocoder Processing' do
  
  describe 'valid response' do
    
    valid_response_hash = {
      'geonames' => {
        'address' => {
          'street' => 'Kenwood Dr',
          'streetNumber' => '598',
          'postalcode' => '94025',
          'placename' => 'Menlo Park',
          'adminName2' => 'San Mateo',
          'adminCode1' => 'CA',
          'countryCode' => 'US'
        }
      }
    }
    
    normalized_hash = {
      :geocoder => 'Geonames',
      :address => 'Menlo Park, 598 Kenwood Dr, San Mateo, CA, 94025, US',
      :country_code => 'US',
      :country_name => 'US'
    }
    
    it 'should return normalized data' do
      response = stub_httparty_response(valid_response_hash, '200')
      ReverseGeocoder::Geonames.stub!(:request).and_return(response)
      response = ReverseGeocoder::Geonames.geocode(90, 180)
      response.should eql(normalized_hash)
    end

  end
  
end
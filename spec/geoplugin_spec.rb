require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'GeoPlugin Geocoder Processing' do
  
  describe 'valid response' do
    
    valid_response_hash = {
      'geoPlugin' => {
        'geoplugin_place' => 'Port Gibson',
        'geoplugin_countryCode' => 'US',
        'geoplugin_regionAbbreviated' => 'MS'
      }
    }
    
    normalized_hash = {
      :geocoder => 'GeoPlugin',
      :address => 'Port Gibson, MS, US',
      :country_code => 'US',
      :country_name => 'US'
    }
    
    it 'should return normalized data' do
      response = stub_httparty_response(valid_response_hash, '200')
      ReverseGeocoder::GeoPlugin.stub!(:request).and_return(response)
      response = ReverseGeocoder::GeoPlugin.geocode(32, 91)
      response.should eql(normalized_hash)
    end

  end
  
end
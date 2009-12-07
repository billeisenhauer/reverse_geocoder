require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'iBegin Geocoder Processing' do
  
  describe 'valid response' do
    
    valid_response_hash = {
      'geocode' => {
        'stcity' => 'Washington',
        'ststate' => 'DC',
        'stzip' => '20502',
        'stnumber' => '1610',
        'stname' => 'Pennsylvania Ave'
      }
    }
    
    normalized_hash = {
      :geocoder => 'iBegin',
      :address => '1610 Pennsylvania Ave, Washington, DC, 20502, US',
      :country_code => 'US',
      :country_name => 'USA'
    }
    
    it 'should return normalized data' do
      response = stub_httparty_response(valid_response_hash, '200')
      ReverseGeocoder::IBegin.stub!(:request).and_return(response)
      response = ReverseGeocoder::IBegin.geocode(38.898747, -77.037947)
      response.should eql(normalized_hash)
    end

  end
  
end
require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Numerex Geocoder Processing' do
  
  describe 'valid response' do
    
    valid_response_hash = {
      'address' => {
        'addr_line1' => '8513 Wellington Point Dr',
        'addr_line2' => 'Irving, TX 75063'
      }
    }
    
    normalized_hash = {
      :geocoder => 'Numerex',
      :address => '8513 Wellington Point Dr, Irving, TX 75063',
      :country_code => '',
      :country_name => ''
    }
    
    it 'should return normalized data' do
      response = stub_httparty_response(valid_response_hash, '200')
      ReverseGeocoder::Numerex.stub!(:request).and_return(response)
      response = ReverseGeocoder::Numerex.geocode(32.9219569943518, -96.9514012365146)
      response.should eql(normalized_hash)
    end

  end
  
end
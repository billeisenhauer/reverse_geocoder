require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Google Geocoder Validations' do
  
  it "should reject invalid option" do
    lambda do 
      ReverseGeocoder::Google.geocode(90, 180, :invalid => 'invalid') 
    end.should raise_error(ArgumentError, "Options cannot include :invalid")
  end
  
end

describe 'Google Geocoder Processing' do
  
  describe 'valid response' do
    
    valid_response_hash = {
      'name' => '1600 Amphitheatre Parkway, Mountain View, CA',
      'Status' => {
        'code' => 200,
        'request' => 'geocode'
      },
      'Placemark' => [
        {
          'id' => 'p1',
          'address' => '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA',
          'AddressDetails' => {
            'Country' => {
              'CountryNameCode' => 'US',
              'CountryName' => 'USA'
            }
          }
        }
      ]
    }
    
    normalized_hash = {
      :geocoder => 'Google',
      :address => '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA',
      :country_code => 'US',
      :country_name => 'USA'
    }
    
    it 'should return normalized data' do
      response = stub_httparty_response(valid_response_hash, '200')
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      response = ReverseGeocoder::Google.geocode(90, 180)
      response.should eql(normalized_hash)
    end
    
  end
  
  describe 'with non-200 responses' do
    
    it 'should raise a malformed request error' do
      response = stub_httparty_response({'Status' => {'code' => '500'}}, 200)
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      lambda do 
        ReverseGeocoder::Google.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::UnknownServiceError)
    end
    
    it 'should raise a malformed request error' do
      response = stub_httparty_response({'Status' => {'code' => '601'}}, 200)
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      lambda do 
        ReverseGeocoder::Google.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::MalformedRequest)
    end
    
    it 'should raise a malformed request error' do
      response = stub_httparty_response({'Status' => {'code' => '602'}}, 200)
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      lambda do 
        ReverseGeocoder::Google.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::UnavailableAddress)
    end
    
    it 'should raise a malformed request error' do
      response = stub_httparty_response({'Status' => {'code' => '603'}}, 200)
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      lambda do 
        ReverseGeocoder::Google.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::UnavailableAddress)
    end    
    
    it 'should raise a malformed request error' do
      response = stub_httparty_response({'Status' => {'code' => '610'}}, 200)
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      lambda do 
        ReverseGeocoder::Google.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::AuthenticationError)
    end
    
    it 'should raise a malformed request error' do
      response = stub_httparty_response({'Status' => {'code' => '620'}}, 200)
      ReverseGeocoder::Google.stub!(:request).and_return(response)
      lambda do 
        ReverseGeocoder::Google.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::QueryLimitExceeded)
    end
    
  end
  
end
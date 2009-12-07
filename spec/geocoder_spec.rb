require File.dirname(__FILE__) + '/spec_helper.rb'

class TestGeocoder
  include ReverseGeocoder::Geocoder
end

describe 'Geocoder Validations' do
  
  it "should reject invalid latitude" do
    lambda do 
      TestGeocoder.geocode(180,180) 
    end.should raise_error(ArgumentError, "Latitude 180 is invalid, try -90 to 90")
  end
  
  it "should reject invalid longitude" do
    lambda do 
      TestGeocoder.geocode(0,200) 
    end.should raise_error(ArgumentError, "Longitude 200 is invalid, try -180 to 180")
  end
  
  it "should reject invalid longitude" do
    lambda do 
      TestGeocoder.geocode(90,180, Array.new) 
    end.should raise_error(ArgumentError, "Options should be Hash, but is a Array")
  end
  
end

describe 'Geocoder Processing' do
  
  describe 'valid response' do
    
    it 'should return hash response' do
      response = stub_httparty_response({:status => '200'}, '200')
      TestGeocoder.stub!(:request).and_return(response)
      response = TestGeocoder.geocode(90, 180)
      response.should eql({:status => '200'})
    end
    
  end
  
  describe 'with non-200 responses' do
    
    it 'should raise an authorization error' do
      response = stub_httparty_response({}, '401')
      TestGeocoder.stub!(:request).and_return(response)
      lambda do 
        TestGeocoder.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::AuthenticationError)
    end
    
    it 'should raise an unknown server error' do
      response = stub_httparty_response({}, '404')
      TestGeocoder.stub!(:request).and_return(response)
      lambda do 
        TestGeocoder.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::UnavailableAddress)
    end
    
    it 'should raise an unknown server error' do
      response = stub_httparty_response({}, '500')
      TestGeocoder.stub!(:request).and_return(response)
      lambda do 
        TestGeocoder.geocode(90, 180)
      end.should raise_error(ReverseGeocoder::UnknownServiceError)
    end
    
  end
  
end
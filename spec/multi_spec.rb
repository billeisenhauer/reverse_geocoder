require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Multi Geocoder' do
  
  it "should contain a list of geocoder providers" do
    geocoder_order = [
      ReverseGeocoder::Google, 
      ReverseGeocoder::Numerex, 
      ReverseGeocoder::Geonames, 
      ReverseGeocoder::GeoPlugin
    ]
    ReverseGeocoder.geocoder_order.should eql(geocoder_order)
  end
  
  google_normalized_hash = {
    :geocoder => 'Google',
    :address => '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA',
    :country_code => 'US',
    :country_name => 'USA'
  }
  
  numerex_normalized_hash = {
    :geocoder => 'Numerex',
    :address => '8513 Wellington Point Dr, Irving, TX 75063',
    :country_code => '',
    :country_name => ''
  }
  
  it 'should call the first geocoder provider' do
    ReverseGeocoder::Google.stub!(:geocode).and_return(google_normalized_hash)
    response = ReverseGeocoder::Multi.geocode(90, 180)
    response.should eql(google_normalized_hash)
  end

  it 'should fail over to the second geocoder provider' do
    ReverseGeocoder::Google.stub!(:geocode).and_raise(ReverseGeocoder::QueryLimitExceeded)
    ReverseGeocoder::Numerex.stub!(:geocode).and_return(numerex_normalized_hash)
    response = ReverseGeocoder::Multi.geocode(90, 180)
    response.should eql(numerex_normalized_hash)
  end
  
end
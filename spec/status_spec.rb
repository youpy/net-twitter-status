$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'

require 'net/twitter/status'

describe Net::Twitter::Status do
  before do
    @status = Net::Twitter::Status.new
  end

  it "should get features" do
    features = @status.features
    features.size.should == 10
    features.names.should be_include('web features')
    features.names.should be_include('SMS')
    features.names.should be_include('user delete/restore')
    features.names.should be_include('person search')
    features.names.should be_include('pagination')
    features.names.should be_include('IM')
    features.names.should be_include('Track')
    features.names.should be_include('badges')
    features.names.should be_include('Facebook app')
    features.names.should be_include('API')

    features.each do |feature|
      feature.should be_respond_to(:name)
      features[feature.name].should_not be_nil
      feature.should be_respond_to(:status)
      feature.should be_respond_to(:message)
      [:ok, :problem, :offline].should be_include(feature.status)
    end
  end
end

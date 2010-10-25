require 'test_helper'

class TestResponse < Test::Unit::TestCase
  context "Hotwire::Response" do
    
    context "from_request" do
      context "for json" do
        setup { @response = Hotwire::Response.from_request(valid_request(:out => 'json')) }
        
        should "be an instance of Hotwire::Response::Json" do
          assert @response.is_a?(Hotwire::Response::Json)
        end
      end
      
      context "for html" do
        setup { @response = Hotwire::Response.from_request(valid_request(:out => 'html')) }
        
        should "be an instance of Hotwire::Response::Html" do
          assert @response.is_a?(Hotwire::Response::Html)
        end
      end
      
      context "for csv" do
        setup { @response = Hotwire::Response.from_request(valid_request(:out => 'csv')) }
        
        should "be an instance of Hotwire::Response::Csv" do
          assert @response.is_a?(Hotwire::Response::Csv)
        end
      end
      
      context "for an invalid type" do
        setup { @response = Hotwire::Response.from_request(valid_request(:out => 'invalid')) }
        
        should "be an instance of Hotwire::Response::Invalid" do
          assert @response.is_a?(Hotwire::Response::Invalid)
        end
      end
    end
    
  end
  
end

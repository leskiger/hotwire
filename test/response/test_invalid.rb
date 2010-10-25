require 'test_helper'

class TestResponseInvalid < Test::Unit::TestCase
  context "the Hotwire::Response::Invalid instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response.from_request(valid_request(:out => 'invalid')) }
      
      context "with valid data" do
        setup do
          @response.add_column("string", :label => "Column A")
          @response.set_data([["a1"]])
        end
        
        should "not be valid" do
          assert !@response.valid?
        end
      end
      
    end

  end
  
end

require 'test_helper'

class TestResponseHtml < Test::Unit::TestCase
  context "the Hotwire::Response::Html instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response.from_request(valid_request(:out => 'html')) }
      
      context "with valid data" do
        setup do
          @response.add_column("string", :label => "Column A")
          @response.set_data([["a1"]])
        end
        
        context "body" do
          should "return html" do
            assert !@response.body
          end
        end
      end
      
    end

  end
  
end

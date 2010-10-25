require 'test_helper'

class TestRequest < Test::Unit::TestCase
  context "a Hotwire::Request instance" do
    
    context "created from params with a valid tqx" do
      setup { @request = Hotwire::Request.from_params({:tqx => "reqId:0;version:0.5"}) }
      should "be valid" do
        assert @request.valid?
      end
      
      should "allow for params to be get and set via [] and []=" do
        @request[:reqId] = 3
        assert_equal 3, @request[:reqId]
      end
      
      should "have a default value of 'json' for :out" do
        assert_equal 'json', @request[:out]
      end
      
      context "build_response" do
        should "wrap Hotwire::Response.from_request" do
          Hotwire::Response.expects(:from_request).with(@request)
          @request.build_response
        end
      end
    end
    
    context "created from params without an unsupported version" do
      setup { @request = Hotwire::Request.from_params({:tqx => "reqId:0;version:99"}) }
      should "not be valid" do
        assert !@request.valid?
        assert !@request.errors.empty?
        assert @request.errors.to_s.include?("Unsupported version 99")
      end
    end
    
    context "created from params without a reqID" do
      setup { @request = Hotwire::Request.from_params({:tqx => "someParam"}) }
      should "not be valid" do
        assert !@request.valid?
        assert !@request.errors.empty?
        assert @request.errors.to_s.include?("Missing required parameter reqId")
      end
    end
    
    context "created from params without tqx" do
      setup { @request = Hotwire::Request.from_params({}) }
      should "be false" do
        assert_equal false, @request
      end
    end
    
  end
  
end

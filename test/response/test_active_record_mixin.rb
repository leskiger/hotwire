require 'test_helper'
require 'active_record_test_helper'


class TestActiveRecordMixin < Test::Unit::TestCase
  context "the Hotwire::Response::Base instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response::Base.new(valid_request) }
      
      context "add_columns" do
        setup { @response.add_columns(Person) }
        
        should "add columns to match the ActiveRecord object" do
          expected = [{:type => "number", :id => "id", :label => 'id'},
                      {:type => "string", :id => "name", :label => 'name'},
                      {:type => "string", :id => "bio", :label => 'bio'},
                      {:type => "number", :id => "age", :label => 'age'},
                      {:type => "number", :id => "weight", :label => 'weight'},
                      {:type => "datetime", :id => "birth_date", :label => 'birth_date'},
                      {:type => "boolean", :id => "tall", :label => 'tall'}]
                      
          assert_equal expected, @response.columns
        end
      end

    end

  end
end

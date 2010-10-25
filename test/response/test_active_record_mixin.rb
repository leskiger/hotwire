require 'test_helper'
require 'active_record_test_helper'


class TestActiveRecordMixin < Test::Unit::TestCase
  context "the Hotwire::Response::Base instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response::Base.new(valid_request) }
      
      context "add_columns with a Model" do
        setup { @response.add_columns(Person) }
        
        should "add columns to match the ActiveRecord object" do
          expected = [{:type=>"number", :label=>"age", :id=>"age"},
                      {:type=>"string", :label=>"bio", :id=>"bio"},
                      {:type=>"datetime", :label=>"birth_date", :id=>"birth_date"},
                      {:type=>"number", :label=>"id", :id=>"id"},
                      {:type=>"string", :label=>"name", :id=>"name"},
                      {:type=>"boolean", :label=>"tall", :id=>"tall"},
                      {:type=>"number", :label=>"weight", :id=>"weight"}]
                      
          assert_equal expected, @response.columns
        end
      end
      
      context "set_data with a collection" do
        setup do
          Person.destroy_all
          @time = Time.utc(1980, 9, 15, 12, 22, 23)
          @bob = Person.create(:name => "Bob", :age => 30, :bio => "A Nice Guy", :birth_date => 30.years.ago, :tall => true, :weight => 155.5)
          @fred = Person.create(:name => "Fred", :age => 22, :bio => "A Nice Guy Too", :birth_date => 22.years.ago, :tall => false, :weight => 110.5)
          @response.add_columns(Person)
          @response.set_data(Person.all)
        end
        
        should "add rows from the collection" do
          expected = [[30, "A Nice Guy", @bob.birth_date, 1, "Bob", true, @bob.weight],
                      [22, "A Nice Guy Too", @fred.birth_date, 2, "Fred", false, @fred.weight]]
                      
          assert_equal expected.to_s, @response.data.to_s
        end
        
      end

    end

  end
end

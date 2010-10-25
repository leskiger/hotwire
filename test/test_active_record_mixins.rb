require 'test_helper'
require 'active_record_test_helper'


class TestActiveRecordMixin < Test::Unit::TestCase
  
  context "a Hotwire::Table instance from an ActiveRecord collection" do
    setup do
      Person.delete_all
      Person.create(:name => "Bob", :age => 33, :bio => "A nice Guy", :birth_date => Time.utc(2010, 10, 19, 9, 38, 10))
      @data = Hotwire::Table.new(Person.all)
    end
    
    context "to_wire" do
      should "return a properly formatted hash" do
        expected = { "table"=> {"rows"=> [{"c"=> [{"v"=>33},
                                                  {"v"=>"A nice Guy"},
                                                  {"v"=>"Date(2010, 9, 19, 9, 38, 10)"},
                                                  {"v"=>"Bob"}]}],
                                "cols"=> [{"type"=>"number", "id"=>"age", "label"=>"Age"},
                                          {"type"=>"string", "id"=>"bio", "label"=>"Bio"},
                                          {"type"=>"datetime", "id"=>"birth_date", "label"=>"Birth date"},
                                          {"type"=>"string", "id"=>"name", "label"=>"Name"}]}}    
          
        assert_equal expected, @data.to_wire
      end
    end
  end
  
  context "an Array of ActiveRecord objects" do
    setup do
      Person.delete_all
      Person.create(:name => "Bob", :age => 33, :bio => "A nice Guy", :birth_date => Time.utc(2010, 10, 19, 9, 38, 10))
      @people = Person.all
    end
    
    context "to_wire" do
      should "return a properly formatted hash" do
        expected = { "table"=> {"rows"=> [{"c"=> [{"v"=>33},
                                                  {"v"=>"A nice Guy"},
                                                  {"v"=>"Date(2010, 9, 19, 9, 38, 10)"},
                                                  {"v"=>"Bob"}]}],
                                "cols"=> [{"type"=>"number", "id"=>"age", "label"=>"Age"},
                                          {"type"=>"string", "id"=>"bio", "label"=>"Bio"},
                                          {"type"=>"datetime", "id"=>"birth_date", "label"=>"Birth date"},
                                          {"type"=>"string", "id"=>"name", "label"=>"Name"}]}}    
          
        assert_equal expected, @people.to_wire
      end
    end
  end
  
  context "an Array of non-ActiveRecord objects" do
    should "raise an error" do
      assert_raises RuntimeError do
        ["string"].to_wire
      end
    end
  end
  
end

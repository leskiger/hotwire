require 'test_helper'

class TestCoreExtensions < Test::Unit::TestCase
  context "a Hash" do
    context "to_wire" do
      context "with propper data" do
        setup do
          time = Time.local(2010, 10, 19, 9, 38, 10)
          @hash = {:columns => ['started at', 'name', 'years', 'location'], :rows => [[time, "bob", 21, nil]]}
        end
        
        should "return a propperly formatted hash" do
          expected = { "table"=> { "rows"=> [ {"c"=> [{"v"=>"Date(2010, 9, 19, 9, 38, 10)"},
                                                      {"v"=>"bob"},
                                                      {"v"=>21},
                                                      {"v"=>0}]}],
                                   "cols"=> [{"type"=>"datetime", "id"=>"started at", "label"=>"Started at"},
                                             {"type"=>"string", "id"=>"name", "label"=>"Name"},
                                             {"type"=>"number", "id"=>"years", "label"=>"Years"},
                                             {"type"=>"string", "id"=>"location", "label"=>"Location"}]}}
          assert_equal expected, @hash.to_wire
        end
      end
    end
  end
end

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'redgreen' unless ENV['TM_MODE']

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_record'

require 'hotwire'

class Test::Unit::TestCase
end

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'redgreen' unless ENV['TM_MODE']
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_record'

require 'hotwire'

class Test::Unit::TestCase
  def default_tqx_options
    {:reqId => 0}
  end
  
  def valid_request tqx_options = {}
    tqx = default_tqx_options.update(tqx_options).map { |key, val|
      "#{key}:#{val}"
    }.join(";")
    Hotwire::Request.from_params({:tqx => tqx})
  end
  
end

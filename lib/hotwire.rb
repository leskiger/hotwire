module Hotwire
  def self.supported_api_versions
    ["0.5"]
  end
end

require 'hotwire/base'
require 'hotwire/request'
require 'hotwire/response'
require 'hotwire/response/base'
require 'hotwire/response/csv'
require 'hotwire/response/json'
require 'hotwire/response/html'
require 'hotwire/response/invalid'



if defined? ActiveRecord::Base
  require 'hotwire/response/active_record_mixin.rb'
end
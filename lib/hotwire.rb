require 'hotwire/core_extensions'
require 'hotwire/column_headers'
require 'hotwire/row'
require 'hotwire/table'

if defined? ActiveRecord::Base
  require 'hotwire/active_record_mixins.rb'
end
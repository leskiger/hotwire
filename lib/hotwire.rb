require 'hotwire/core_extensions'
require 'hotwire/column_headers'
require 'hotwire/row'
require 'hotwire/data'

if defined? ActiveRecord::Base
  require 'hotwire/active_record_mixin.rb'
  Hotwire::Data.send(:include, Hotwire::ActiveRecordMixin) 
end
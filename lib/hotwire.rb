require 'hotwire/core_extensions.rb'
require 'hotwire/column_headers.rb'
require 'hotwire/row.rb'
require 'hotwire/data.rb'

if defined? ActiveRecord::Base
  require 'hotwire/active_record_mixin.rb'
  Hotwire::Data.send(:include, Hotwire::ActiveRecordMixin) 
end
require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :people do |t|
    t.string :name
    t.text :bio
    t.integer :age
    t.datetime :birth_date
  end
end

class Person < ActiveRecord::Base
end
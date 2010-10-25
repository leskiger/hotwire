require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :people do |t|
    t.integer :id
    t.string :name
    t.text :bio
    t.integer :age
    t.decimal :weight
    t.datetime :birth_date
    t.boolean :tall
  end
end

class Person < ActiveRecord::Base
end
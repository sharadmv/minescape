require 'sequel'

DB = Sequel.connect('postgres://geraldfong:@localhost:5432/postgres')

DB.create_table(:players) do 
  primary_key :id
  String :name
  Float :x
  Float :y
end

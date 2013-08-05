require_relative '../lib/util'
DB.create_table(:players) do 
  primary_key :id
  String :name
  Float :x
  Float :y
end

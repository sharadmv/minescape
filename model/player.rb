require 'sequel'

DB = Sequel.connect('postgres://geraldfong:@localhost:5432/postgres')
class Player < Sequel::Model
end

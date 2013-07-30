require 'yaml'
require 'sequel'

module Util
  @@db = nil

  def self.db
    load_db unless @@db
    @@db
  end

  def self.load_db
    @@db = Sequel.connect(database_string)
  end

  def self.database_string
    conf = YAML.load_file('./config.yml')['db']
    "postgres://#{conf['user']}:#{conf['password']}@#{conf['host']}:#{conf['port']}/postgres"
  end
end

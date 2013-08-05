require 'yaml'
require 'sequel'

module Util
  def self.database_string
    conf = YAML.load_file('./config.yml')['db']
    "postgres://#{conf['user']}:#{conf['password']}@#{conf['host']}:#{conf['port']}/#{conf['database']}"
  end
end

DB = Sequel.connect(Util.database_string)

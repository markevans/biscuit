require 'activerecord'
require 'biscuit/cookie'

module Biscuit
  class << self
    
    def connect!(db_file=nil)
      @connection = ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        :database  => db_file || File.expand_path("~/Library/Application Support/Google/Chrome/Default/Cookies")
      )
    end

    attr_reader :connection
    
  end
end

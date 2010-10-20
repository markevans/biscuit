require 'uri'

module Biscuit
  class Cookie < ActiveRecord::Base
    
    # SQL escaping is for losers
    scope :for_host, lambda{|host|
      where("host_key LIKE '%#{host}'")
    }
    scope :for_path, lambda{|path|
      path = path.gsub(%r{^/|/$},'')
      bits = path.split('/')
      q = bits.inject(['/']){|arr, bit|
        last = arr.last
        arr << "#{last}#{bit}"
        arr << "#{last}#{bit}/"
        arr
      }.map{|pth|
        "path LIKE '#{pth}'"
      }.join(" OR ")
      where(q)
    }
    
    def self.for_url(url)
      uri = URI.parse(url)
      for_host(uri.host).for_path(uri.path)
    end
    
    def self.to_mozilla_file(url)
      uri = URI.parse(url)
      File.open("#{uri.host}-#{uri.path.gsub('/','_')}.cookies", 'w') do |file|
        for_url(url).each do |cookie|
          file.puts cookie.to_mozilla
        end
      end
    end
    
    def to_mozilla
      "#{host_key} TRUE #{path} #{bool_for(secure)} #{expires_utc} #{name} #{value}"
    end
    
    private
    
    def bool_for(int)
      int.zero? ? "FALSE" : "TRUE"
    end
    
  end
end

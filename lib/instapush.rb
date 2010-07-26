# encoding: UTF-8

require 'rest_client'

# InstaPush.connect username, password 
class InstaPush
  def self.connect(username, password = nil)
    conn = new username, password
    
    if block_given?
      yield conn
    else
      conn
    end
  end
  
  attr_reader :username, :password, :api_url
  
  def initialize(username, password)
    @username = username
    @password = password
    @api_url = "https://www.instapaper.com/api/"
  end
  
  def authenticate
    RestClient.post authenticate_url,
                    :username => username,
                    :password => password
  rescue RestClient::RequestFailed
    errors << $!
    false
  end
  
  def add(url, opts = {})
    opts.merge! :url      => url,
                :username => username, 
                :password => password
    
    RestClient.post add_url, opts
  rescue RestClient::RequestFailed
    errors << $!
    false
  end
  
  def errors
    @errors ||= []
  end
  
  def method_missing(sym)
    raise NoMethodError unless sym.to_s.include? '_url'
    api_url + sym.to_s.chomp('_url')
  end
end
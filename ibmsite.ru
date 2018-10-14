require 'json'
require 'rack'
require 'thin'

class IBMsite
  def initialize
    @ip_buckets = Hash.new(0)
  end

  #
  # I could have used Sys::Uptime, but I figured I'd use a minimum of gems
  def uptime
    "#{Time.now - IO.read('/proc/uptime').split[0].to_f}"
  end

  def resp_json
    {
      siteUpSince: uptime,
      IPs: @ip_buckets
    }.to_json
  end

  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when '/'
      @ip_buckets[env['REMOTE_ADDR']] += 1
      [200, {"Content-Type" => "text/html"}, [resp_json]]
    else
      [404, {"Content-Type" => "text/html"}, ["These are not the droids you're looking for..."]]
    end
  end
end

Rack::Handler::Thin.run(IBMsite.new, Host: '0.0.0.0', Port: 8888)

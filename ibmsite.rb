require 'json'

class IBMSite
  def initialize
    @ip_buckets = Hash.new(0)
    @start_time = Time.now
  end

  #
  # I could have used Sys::Uptime, but I figured I'd use a minimum of gems
  def uptime
    Time.now - @start_time
  end

  def system_uptime
    Time.now - IO.read('/proc/uptime').split[0].to_f
  end

  def resp_json(type)
    uptime = case type
             when :system
               system_uptime
             when :start_time
               @start_time
             else
               @uptime
             end

    {
      siteUpSince: uptime,
      IPs: @ip_buckets
    }.to_json
  end

  def call(env)
    req = Rack::Request.new(env)

    @ip_buckets[req.ip] += 1 unless ['/favicon.ico', '/robots.txt'].include? req.path_info

    case req.path_info
    when '/', '/service'
      [200, {"Content-Type" => "application/json"}, [resp_json(:start_time)]]
    when '/system'
      [200, {"Content-Type" => "application/json"}, [resp_json(:system)]]
    else
      [404, {"Content-Type" => "text/html"}, ["These are not the droids you're looking for..."]]
    end
  end
end

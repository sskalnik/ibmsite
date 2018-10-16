require 'rack'
require './ibmsite'

if ['development', 'test'].include? ENV['RACK_ENV']
  port = 8888
else
  port = 80
end

Rack::Handler.default.run(IBMSite.new, Host: '0.0.0.0', Port: port)

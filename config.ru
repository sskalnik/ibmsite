require 'rack'
require './ibmsite'

Rack::Handler.default.run(IBMsite.new, Host: '0.0.0.0', Port: 8888)

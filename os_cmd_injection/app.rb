# frozen_string_literal: true

require 'sinatra'
require 'shellwords'

# curl "http://127.0.0.1:4567/api/v1/echo/hello-world"
# curl "http://127.0.0.1:4567/api/v1/echo/hello-world&&ls"
get '/api/v1/echo/:msg' do |msg|
  `echo #{msg}`
end

# curl "http://127.0.0.1:4567/api/v2/echo/hello-world"
# curl "http://127.0.0.1:4567/api/v2/echo/hello-world&&ls"
get '/api/v2/echo/:msg' do |msg|
  `echo #{Shellwords.escape(msg)}`
end

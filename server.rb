$:.unshift File.join(Dir.pwd, 'lib')

require 'sinatra'
require 'haml'
require 'utils'
require 'media'

if development?
  require 'sinatra/reloader'
end

set :haml, :format => :html5

get '/' do
  haml :index
end

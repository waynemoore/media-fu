require 'sinatra'
require 'haml'

if development?
  require 'sinatra/reloader'
end

set :haml, :format => :html5

get '/' do
  haml :index
end

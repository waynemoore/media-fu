$:.unshift File.join(Dir.pwd, 'lib')

require 'sinatra'
require 'haml'
require 'utils'
require 'media'
require 'parser'

if development?
  require 'sinatra/reloader'
end

set :haml, :format => :html5

# App settings
INCOMING_DIR = File.join(Dir.pwd, 'tmp')

# controllers
get '/' do
  media_list = parse_file_names INCOMING_DIR
  haml :index, :locals => {
    :tv_shows => media_list.find_all {|item| item[:type] == :tv_show},
    :movies => media_list.find_all {|item| item[:type] == :movie}
  }
end

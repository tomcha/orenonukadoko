require 'sinatra/base'
require 'haml'

class Orenonukadoko< Sinatra::Base
  get '/' do
    haml :index
  end
end

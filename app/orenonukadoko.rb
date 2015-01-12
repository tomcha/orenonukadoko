require 'sinatra/base'
require 'haml'
require 'omniauth'
require 'omniauth-twitter'
require 'activerecord'
require 'sqlite3'

class Orenonukadoko< Sinatra::Base
  get '/' do
    haml :index
  end
end

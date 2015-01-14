require 'sinatra/base'
require 'haml'
require 'omniauth'
require 'omniauth-twitter'
require 'active_record'
require 'sqlite3'

class Orenonukadoko< Sinatra::Base

  configure do
    set :public_folder, File.expand_path(File.join(root, '..', 'public'))
    enable :sessions

    twitter_config = Hash.new
    File.open(File.expand_path(File.join(root, '..', 'config', 'twitter_config.txt'))) do |file|
      file.each_line do |text|
        (key,value) = text.split(":")
        twitter_config[key] = value
      end
      twitter_config['access_token'] = ''
      twitter_config['access_token_secret'] = ''
    end

    use OmniAuth::Builder do
      provider :twitter, twitter_config['consumer_key'], twitter_config['consumer_secret']
    end
  end

  get '/' do
    haml :index
  end
end

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
        (key,value) = text.chomp.split(":")
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
    if(session[:uid])
      @screen_name = session[:screen_name]
      @profile_image_icon= session[:profile_image_icon]
      @uid = session[:uid]
      @signin_link = '#'
    else
      @signin_link = '/auth/twitter'
    end 

    haml :index
  end

  get '/auth/twitter/callback' do
    #処理にとばす
    #成功
    @authorized_hash = request.env['omniauth.auth']
    session[:screen_name] = @authorized_hash['info'].nickname
    session[:profile_image_icon] = @authorized_hash['info'].image
    session[:uid] = @authorized_hash['uid']
    redirect '/'
    #失敗
  end

  get '/signout' do
    session[:uid] = nil
    session[:screenname] = nil
    session[:profile_image_icon] = nil
    redirect '/'
  end
end

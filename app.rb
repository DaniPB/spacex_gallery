# app.rb

require 'sinatra'
require 'faraday'
require 'puma'
require 'sinatra/base'
require 'sinatra/custom_logger'
require 'logger'

require './services/get_last_launch.rb'

class App < Sinatra::Base

  set :bind, '0.0.0.0'
  set :port, 80
  set :public_folder, File.dirname(__FILE__) + '/static'

  get '/' do
    "Hello World"
  end

  get '/gallery' do
    launch_info = GetLastLaunch.new.()
    @name = launch_info[:name]
    @images = launch_info[:images]
    @date = launch_info[:launch_date_local]
    console.log(@name)

    erb :gallery
  end

  run! if app_file == $0
end

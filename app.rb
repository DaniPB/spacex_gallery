# app.rb

require 'sinatra'
require 'faraday'
require 'puma'
require 'sinatra/base'
require 'sinatra/custom_logger'
require 'logger'

require './services/create_payment_methods.rb'
require './services/request_trips.rb'
require './services/finish_trips.rb'

configure { set :server, :puma }

class App < Sinatra::Base
  helpers Sinatra::CustomLogger

  set :bind, '0.0.0.0'
  set :port, 8080
  set :current_dir, Dir.pwd

  Dir["#{settings.current_dir}/models/*.rb"].each { |file| require file }

  configure :development, :production do
    logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  get '/' do
    "Hello World"
  end

  run! if app_file == $0
end

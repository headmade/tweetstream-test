# coding: UTF-8

set :stages, %w(staging production)
set :default_stage, "staging"

require 'capistrano/ext/multistage'
require "bundler/capistrano"
require "rvm/capistrano"
require 'capi/unicorn'

load 'config/deploy/settings.rb'

before 'deploy:setup', 'rvm:install_ruby'
after "deploy:restart", "unicorn:restart"

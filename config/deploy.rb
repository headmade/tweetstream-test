# coding: UTF-8

set :stages, %w(staging production)
set :default_stage, "staging"

require 'capistrano/ext/multistage'
require "bundler/capistrano"
require "rvm/capistrano"

load 'config/deploy/settings.rb'

before 'deploy:setup', 'rvm:install_ruby'

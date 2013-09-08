default_run_options[:pty] = true
set :application, "tweetstream"
set :repository,  "git@github.com:headmade/tweetstream-test.git"

set :ssh_options, { :forward_agent => true }
set :run_method, :run

set :scm, :git
set :deploy_via, :remote_cache
set :rake, 'bundle exec rake'

set :rvm_ruby_string, "ruby-1.9.3-p448@tweetstream_test"
set :rvm_install_ruby, :install
set :rvm_install_ruby_threads, 8

set :default_environment, {
    'PATH' => "/usr/local/bin:/usr/bin:/bin",
}

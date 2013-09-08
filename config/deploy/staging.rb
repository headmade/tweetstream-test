set :rails_env, "production"
set :branch,  fetch(:branch, ENV["BRANCH"] || `git branch 2>/dev/null | grep '^*' | awk '{ print $2 }'`.chomp)

set :user, "deploy"
set :use_sudo, false

set :deploy_to, "/u/apps/tweetstream"

role :web, "192.241.186.201"                          # Your HTTP server, Apache/etc
role :app, "192.241.186.201"                          # This may be the same as your `Web` server
role :db,  "192.241.186.201", :primary => true # This is where Rails migrations will run

set :unicorn_pid_file, "#{deploy_to}/shared/pids/unicorn.pid"
#set :unicorn_conf, "#{deploy_to}/current/config/unicorn.conf"

# config valid for current version and patch releases of Capistrano
# lock "~> 3.18.0"
lock '~> 3.17'

set :application, "soccer_bet"
set :repo_url, "git@github.com:l-plan/soccer_bet.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :always




set :rvm1_ruby_version, '3.2.1'
set :rails_env, "production"
ask(:password, nil, echo: false)

set :conditionally_migrate, true
set :passenger_rvm_ruby_version, '3.2.1'
set :passenger_restart_with_touch, true
# set :passenger_restart_options, -> { "#{deploy_to.downcase} --ignore-app-not-running" }
set :log_level, :debug

set :linked_files, fetch(:linked_files, []).push('config/master.key' )


append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'storage', '.bundle'



require 'bundler/capistrano'

set :application, "okrsky"
set :repository,  "."
set :deploy_via, :copy
set :local_repository, "."

role :web, "server.kubicek.cz"                          # Your HTTP server, Apache/etc
role :app, "server.kubicek.cz"                          # This may be the same as your `Web` server
role :db,  "server.kubicek.cz", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/svobodni/okrsky/"
set :user, "okrsky"
set :use_sudo, false

task :create_symlinks  do
  run "ln -nfs #{shared_path}/production.sqlite3 #{release_path}/db/production.sqlite3"
  run "ln -nfs #{shared_path}/production.rb #{release_path}/config/configatron/production.rb"
end

after "deploy:finalize_update", "create_symlinks"
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
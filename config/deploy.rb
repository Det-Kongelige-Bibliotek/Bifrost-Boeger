set :stages, %w(production staging testing)
set :default_stage, "testing"
require 'capistrano/ext/multistage'

set :application, "SIFD Valhal"
set :repository, "https://github.com/Det-Kongelige-Bibliotek/Bifrost-boeger"


set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
               # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "sifd-hydra.kb.dk" # Your HTTP server, Apache/etc
#role :app, "sifd-hydra.kb.dk" # This may be the same as your `Web` server
               #role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
               #role :db,  "your slave db-server here"
require "bundler/capistrano"
               # if you want to clean up old releases on each deploy uncomment this:
               # after "deploy:restart", "deploy:cleanup"

               # if you're still using the script/reaper helper you will need
               # these http://github.com/rails/irs_process_scripts

               # If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :stop_hydra do
    run "echo #{current_path}"
    if File.directory?(current_path)
      run "cd '#{current_path}' && #{rake} jetty:stop RAILS_ENV=#{rails_env}"
      run "sleep 10"
    end
  end


  task :symlink_shared do
#    run "ln -s #{shared_path}/application.local.yml #{release_path}/config/"
  end
  task :clean do
    rake = fetch(:rake, 'rake')
    rails_env = fetch(:rails_env, 'production')
  end
  task :start do
    ;
  end
  task :stop do

  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    rake = fetch(:rake, 'rake')
    run "ln -s #{shared_path}/jetty #{current_path}/jetty"
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

after :deploy, "deploy:restart"




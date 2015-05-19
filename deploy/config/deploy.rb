set :scm, :git

set :linked_files, %w{config/database.yml config/secrets.yml config/email.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :rvm_ruby_version, '2.1.1'
set :rvm_type, :user
set :rvm_path, '~/.rvm'
set :bundle_jobs, 4
set :keep_releases, 5

set :branch, ENV.fetch("REVISION", 'master')
set :deploy_to, '/var/www/matekarte'

set :repo_url, 'https://github.com/zealot128/matekarte.git'

before 'deploy:assets:precompile', 'deploy:migrate'

desc 'ping server for passenger restart'
task :ping_restart do
  run_locally do
    execute "curl -XGET -I --silent http://www.mate-karte.de"
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :finishing, 'deploy:cleanup'
  # after 'published', :update_crontab
  after 'restart', :ping_restart
end

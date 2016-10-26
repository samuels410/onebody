lock '3.4.0'

set :application, 'onebody'
set :repo_url, 'git://github.com/samuels410/onebody'
set :deploy_to, '/var/deploy/capistrano/onebody'

set :linked_files, %w(config/database.yml config/email.yml config/secrets.yml)

set :linked_dirs, %w(log tmp public/system)

set :bundle_flags, '--deployment'

namespace :deploy do
  # before :finished, 'newrelic:notice_deployment'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

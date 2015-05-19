set :stage, 'production'


set :application, 'matekarte'
server 'lnxhn04-intern',
  user: 'stefan',
  roles: %w{web app db sidekiq},
  forward_agent: true,
  auth_methods: %w(publickey)

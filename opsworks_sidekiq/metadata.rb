name             'opsworks_sidekiq'
version          '0.1.0'

depends 'god'

recipe 'opsworks_sidekiq', 'Launches sidekiq'
recipe 'opsworks_sidekiq::restart', 'Restarts sidekiq'
recipe 'opsworks_sidekiq::stop', 'Stops sidekiq'

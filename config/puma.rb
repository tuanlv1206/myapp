workers Integer(ENV['SHUFFLE_WEB_CONCURRENCY'] || 2)
# We're not sure the code is threadsafe just yet, so don't do multi threaded
threads_count = Integer(ENV['SHUFFLE_MAX_THREADS'] || 1)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
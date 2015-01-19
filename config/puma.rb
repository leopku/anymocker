APP_ROOT = File.expand_path('../..', __FILE__)
pidfile "#{APP_ROOT}/tmp/puma.pid"
state_path "#{APP_ROOT}/tmp/puma.state"
daemonize true
workers 1
threads 2,16
preload_app!

##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # Use better_errors
  # set :protect_from_csrf, except: %r{/__better_errors/\w+/\w+\z} if Padrino.env == :development
  disable :protect_from_csrf
  # enable :sessions
  # set :session_secret, '1df6cc9475fd8699532de1f5678c0d660ad1d8784b836560fcd8aac267ab5f04'
  set :protection, :except => :path_traversal
  # set :protect_from_csrf, true
end

# Mounts the core application for this project

Padrino.mount("Anymocker::Admin", :app_file => Padrino.root('admin/app.rb')).to("/admin")
Padrino.mount('Anymocker::App', :app_file => Padrino.root('app/app.rb')).to('/')

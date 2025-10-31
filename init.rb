require 'redmine'

plugin_root = File.expand_path(__dir__)
lib_path = File.join(plugin_root, 'lib')

if defined?(Rails.autoloaders) && Rails.autoloaders.respond_to?(:main)
  autoloader = Rails.autoloaders.main
  autoloader.push_dir(lib_path) unless autoloader.dirs.include?(lib_path)
else
  deps = ActiveSupport::Dependencies.autoload_paths
  deps << lib_path unless deps.include?(lib_path)
end

config = Rails.application.config
if config.respond_to?(:eager_load_paths) && !config.eager_load_paths.include?(lib_path)
  config.eager_load_paths += [lib_path]
end

require_relative 'lib/redmine_git_remote'

Redmine::Scm::Base.add "GitRemote"

Redmine::Plugin.register :redmine_git_remote do
  name 'Redmine Git Remote'
  author 'Alex Dergachev'
  url 'https://github.com/dergachev/redmine_git_remote'
  description 'Automatically clone and fetch remote git repositories'
  version '0.0.2'

  settings :default => {
    'git_remote_repo_clone_path' => Pathname.new(__FILE__).join("../").realpath.to_s + "/repos",
  }, :partial => 'settings/git_remote_settings'
end

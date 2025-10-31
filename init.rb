require 'redmine'

plugin_root = File.expand_path(__dir__)
lib_path = File.join(plugin_root, 'lib')

if defined?(Rails.autoloaders) && Rails.autoloaders.respond_to?(:main)
  Rails.autoloaders.main.push_dir(lib_path)
else
  ActiveSupport::Dependencies.autoload_paths << lib_path
end

Rails.application.config.eager_load_paths << lib_path unless Rails.application.config.eager_load_paths.include?(lib_path)

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

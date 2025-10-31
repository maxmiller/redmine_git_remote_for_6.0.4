# frozen_string_literal: true

module RedmineGitRemote
end

ActiveSupport::Reloader.to_prepare do
  require_dependency 'repositories_helper'

  patch = RedmineGitRemote::RepositoriesHelperPatch

  unless RepositoriesHelper.included_modules.include?(patch)
    RepositoriesHelper.include patch
  end
end

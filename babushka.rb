dep 'build.clean' do
  clean in_build_dir {|path| path}
end

dep 'downloads.clean' do
  clean in_download_dir {|path| path}
end

dep 'deps up-to-date' do
  repo = Babushka::GitRepo.new '~/.babushka/deps'
  setup { !repo.ahead? or unmeetable("There are local changes in #{repo.path}.") }
  met? { !repo.behind? }
  before { repo.repo_shell 'git fetch origin' }
  meet { repo.reset_hard! 'origin/master' }
end
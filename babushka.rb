dep 'build.clean' do
  clean in_build_dir {|path| path}
end

dep 'downloads.clean' do
  clean in_download_dir {|path| path}
end

dep 'deps up-to-date' do
  repo = Babushka::GitRepo.new '~/.babushka/deps'
  met? { repo.clean? or unmeetable("There are local changes in #{repo.path}.") }
  meet { repo.reset_hard! 'origin/master' }
end
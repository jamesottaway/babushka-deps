dep 'babushka-deps.cloned' do
  requires 'github has my public key'
  repo 'git@github.com:jamesottaway/babushka-deps.git'
  destination '~/.babushka/deps'
end

dep 'bootstrap' do
  requires 'babushka-deps.cloned'
end

dep 'remote tools' do
  requires 'Screen Sharing', 'Remote Login'
end
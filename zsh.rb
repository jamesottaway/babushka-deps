dep 'oh-my-zsh.cloned' do
  repo 'git://github.com/robbyrussell/oh-my-zsh.git'
  destination '~/.oh-my-zsh'
end

dep 'zsh default shell' do
  requires 'benhoskings:zsh.managed'
  met? { sudo("dscl localhost -read /Local/Default/Users/#{shell 'whoami'} shell")['/bin/zsh'] }
  meet { shell 'chsh -s /bin/zsh' }
end

dep 'zsh' do
  requires 'zsh default shell', 'oh-my-zsh.cloned', 'dot files'
end
  
dep 'ssh keys' do
  setup { define_var :ssh_dir, :message => 'Where do your SSH keys live? ', :default => '~/.ssh' }
  met? { (var(:ssh_dir) / 'id_rsa.pub').exists? && (var(:ssh_dir) / 'id_rsa').exists? }
  prepare { define_var :ssh_password, :message => 'What passphrase do you want to encrypt your SSH keys with?' }
  meet { shell "ssh-keygen -t rsa -N #{var :ssh_password} -f #{var :ssh_dir}/id_rsa" }
end
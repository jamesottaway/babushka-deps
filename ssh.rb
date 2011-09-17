dep 'ssh keys' do
  ssh_dir = '~/.ssh'.to_fancypath
  public_key = ssh_dir / 'id_rsa.pub'
  private_key = ssh_dir / 'id_rsa'
  met? { public_key.exists? && private_key.exists? }
  prepare {
    define_var :email, :message => 'What is your email address?'
    define_var :ssh_passphrase, :message => 'What passphrase do you want to encrypt your SSH keys with?'
    define_var :ssh_path, :message => 'Where should we store your SSH keys?', :default => '~/.ssh'
  }
  meet { shell "ssh-keygen -t rsa -N #{var :ssh_passphrase} -C #{var :email} -f #{var :ssh_path}/id_rsa" }
end
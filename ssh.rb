dep 'ssh keys' do
  ssh_dir = '~/.ssh'.to_fancypath
  public_key = ssh_dir / 'id_rsa.pub'
  private_key = ssh_dir / 'id_rsa'
  met? { public_key.exists? && private_key.exists? }
  prepare { define_var :email, :message => 'What is your email address?' }
  meet { shell "ssh-keygen -t rsa -C #{var :email}" }
end
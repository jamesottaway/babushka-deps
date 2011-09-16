dep 'github has my public key' do
  requires 'ssh keys'
  github_api = 'https://api.github.com'
  define_var :github_username, :message => 'What is your GitHub username?', :default => 'jamesottaway'
  define_var :github_password, :message => 'What is your GitHub password?'
  set :public_key, shell('cat ~/.ssh/id_rsa.pub')
  met? { raw_shell('ssh -T git@github.com 2>&1').stdout['successfully authenticated'] }
  prepare { set :hostname, shell('hostname') }
  meet { shell "curl -u '#{var :github_username}:#{var :github_password}' -d '{\"title\": \"#{var :hostname}\", \"key\": \"#{var :public_key}\"}' #{github_api}/user/keys" }
end
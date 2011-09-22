dep 'github has my public key' do
  requires 'ssh keys'
  define_var :github_username, :message => 'What is your GitHub username?'
  define_var :github_password, :message => 'What is your GitHub password?'
  met? { raw_shell('ssh -T git@github.com 2>&1').stdout['successfully authenticated'] }
  prepare {
    set :hostname, shell('hostname')
    set :public_key, shell('cat ~/.ssh/id_rsa.pub')
    set :github_api, 'https://api.github.com'
  }
  meet {
    auth = "#{var :github_username}:#{var :github_password}"
    args = "{\"title\": \"#{var :hostname}\", \"key\": \"#{var :public_key}\"}"
    shell "curl -u '#{auth}' -d '#{args}' #{var :github_api}/user/keys"
  }
end
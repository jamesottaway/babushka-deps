dep 'bootstrap personal deps' do
  requires 'github has my public key'
  define_var :github_username, :message => 'What is your GitHub username?', :default => 'jamesottaway'
  define_var :babushka_deps_repo, :message => 'What is your Babushka deps repo called?', :default => 'babushka-deps'
  setup { @repo = "git@github.com:#{var :github_username}/#{var :babushka_deps_repo}.git" }
  met? { shell('(cd ~/.babushka/deps && git remote show origin)')[@repo] }
  meet { shell "git clone #{@repo}" }
end
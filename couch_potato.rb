dep 'CouchPotato' do
  destination = '/Applications'.to_fancypath / name
  met? { destination.exists? && !destination.empty? }
  meet {
    handle_source 'git://github.com/RuudBurger/CouchPotato.git' do |repo|
      in_build_dir do |build_dir|
        app = build_dir / repo.basename
        app.copy destination
      end
    end
  }
end

dep 'CouchPotato-launchctl.gist' do
  requires 'CouchPotato'
  define_var :couchpotato_app, :default => '/Applications/CouchPotato/CouchPotato.app', :message => 'Where does CouchPotato.app live?'
  source 'https://raw.github.com/gist/fff0bc9d4ca201d7dfd3/8bb886afd026a0112cc6b861dcff51cd76ee8ace/com.couchpotato.couchpotato.plist'
  destination '~/Library/LaunchAgents/com.couchpotato.couchpotato.plist'
  arguments ({ '$COUCHPOTATO_APP' => var(:couchpotato_app) })
  after {
    shell 'launchctl load ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist'
    shell 'launchctl start com.couchpotato.couchpotato.plist'
  }
end
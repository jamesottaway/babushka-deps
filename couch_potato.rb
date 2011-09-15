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

dep 'CouchPotato.launchagent' do
  requires 'CouchPotato'
  define_var :couchpotato_app, :default => '/Applications/CouchPotato/CouchPotato.app', :message => 'Where does CouchPotato.app live?'
  plist 'com.couchpotato.couchpotato.plist'
  source 'https://raw.github.com/gist/fff0bc9d4ca201d7dfd3/8d054820e9383c223c1b7fc407211582ffb712f5/com.couchpotato.couchpotato.plist'
  arguments ({ '$COUCHPOTATO_APP' => var(:couchpotato_app) })
end
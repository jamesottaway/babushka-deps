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
  set :couchpotato_label, 'com.couchpotato.couchpotato'
  define_var :couchpotato_app, :default => '/Applications/CouchPotato/CouchPotato.app', :message => 'Where does CouchPotato.app live?'
  set :couchpotato_binary, 'applet'
  source 'https://gist.github.com/raw/fff0bc9d4ca201d7dfd3/2fa887550afe6cae5a3978405c427d0b39985281/com.app.app.plist'
  destination '~/Library/LaunchAgents/com.couchpotato.couchpotato.plist'
  arguments ({ '$LABEL' => var(:couchpotato_label), '$APP' => var(:couchpotato_app), '$BINARY' => var(:couchpotato_binary) })
  after {
    shell 'launchctl load ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist'
    shell "launchctl start #{var(:couchpotato_label)}"
  }
end

dep 'CouchPotato-config.gist' do
  requires 'CouchPotato'
  define_var :couchpotato_username, :message => 'Couch Potato Username', :default => 'admin'
  define_var :couchpotato_password, :message => 'Couch Potato Password'
  define_var :sabnzbd_username, :message => 'SABnzbd Username'
  define_var :sabnzbd_password, :message => 'SABnzbd Password'
  define_var :sabnzbd_host, :message => 'SABnzbd Host', :default => 'localhost'
  define_var :sabnzbd_port, :message => 'SABnzbd Port', :default => '8080'
  define_var :sabnzbd_api_key, :message => 'SABnzbd API Key'
  define_var :sabnzbd_movies_download_dir, :message => 'Where does SABnzbd store completed movie downloads?'
  define_var :plex_movies_dir, :message => 'Where does Plex scan for movies?'
  define_var :nzbmatrix_username, :message => 'NZBMatrix Username'
  define_var :nzbmatrix_api_key, :message => 'NZBMatrix API Key'
  define_var :twitter_username_token, :message => 'Twitter Username Token'
  define_var :twitter_password_token, :message => 'Twitter Password Token'
  source 'https://raw.github.com/gist/80ac401612dd56db2317/236af050e9f62861fe3283b84c15bf1b34337a65/couchpotato.ini'
  destination '/Applications/CouchPotato/config.ini'
  arguments ({
    '$COUCHPOTATO_USERNAME' => var(:couchpotato_username),
    '$COUCHPOTATO_PASSWORD' => var(:couchpotato_password),
    '$SABNZBD_USERNAME' => var(:sabnzbd_username),
    '$SABNZBD_PASSWORD' => var(:sabnzbd_password),
    '$SABNZBD_HOST' => var(:sabnzbd_host),
    '$SABNZBD_PORT' => var(:sabnzbd_port),
    '$SABNZBD_API_KEY' => var(:sabnzbd_api_key),
    '$SABNZBD_MOVIES_DOWNLOAD_DIR' => var(:sabnzbd_movies_download_dir),
    '$PLEX_MOVIES_DIR' => var(:plex_movies_dir),
    '$NZBMATRIX_USERNAME' => var(:nzbmatrix_username),
    '$NZBMATRIX_API_KEY' => var(:nzbmatrix_api_key),
    '$TWITTER_USERNAME_TOKEN' => var(:twitter_username_token),
    '$TWITTER_PASSWORD_TOKEN' => var(:twitter_password_token)
    })
end
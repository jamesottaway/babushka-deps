require 'securerandom'

dep 'SABnzbd.app' do
  source 'http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/sabnzbd-0.6.9/SABnzbd-0.6.9-osx-lion.dmg?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsabnzbdplus%2Ffiles%2Fsabnzbdplus%2Fsabnzbd-0.6.9%2F&ts=1316039666&use_mirror=internode'
end

dep 'SABnzbd.app', :for => :snow_leopard do
  source 'http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/sabnzbd-0.6.9/SABnzbd-0.6.9-osx.dmg?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsabnzbdplus%2Ffiles%2Fsabnzbdplus%2Fsabnzbd-0.6.9%2F&ts=1316039619&use_mirror=internode'
end

dep 'SABnzbd-launchctl.gist' do
  requires 'SABnzbd.app'
  set :sabnzbd_label, 'com.sabnzbd.sabnzbd'
  define_var :sabnzbd_app, :default => '/Applications/SABnzbd.app', :message => 'Where does SABnzbd.app live?'
  set :sabnzbd_binary, 'SABnzbd'
  source 'https://gist.github.com/raw/fff0bc9d4ca201d7dfd3/2fa887550afe6cae5a3978405c427d0b39985281/com.app.app.plist'
  destination '~/Library/LaunchAgents/com.sabnzbd.sabnzbd.plist'
  arguments ({ '$LABEL' => var(:sabnzbd_label), '$APP' => var(:sabnzbd_app), '$BINARY' => var(:sabnzbd_binary) })
  after {
    shell 'launchctl load ~/Library/LaunchAgents/com.sabnzbd.sabnzbd.plist'
    shell "launchctl start #{var(:sabnzbd_label)}"
  }
end

dep 'SABnzbd-config.gist' do
  requires 'SABnzbd.app'
  define_var :sabnzbd_username, :message => 'SABnzbd Username', :default => 'admin'
  define_var :sabnzbd_password, :message => 'SABnzbd Password'
  define_var :sabnzbd_api_key, :message => 'SABnzbd API Key', :default => SecureRandom.hex
  define_var :sabnzbd_nzb_key, :message => 'SABnzbd NZB Key', :default => SecureRandom.hex
  define_var :nzbmatrix_username, :message => 'NZBMatrix Username'
  define_var :nzbmatrix_api_key, :message => 'NZBMatrix API Key'
  define_var :usenet_host, :message => 'Usenet Host'
  define_var :usenet_port, :message => 'Usenet Port'
  define_var :usenet_username, :message => 'Usenet Username'
  define_var :usenet_password, :message => 'Usenet Password'
  define_var :usenet_num_connections, :message => 'Usenet Number of Connection', :default => '20'
  define_var :usenet_use_ssl, :message => 'Usenet SSL?', :default => '1'
  source 'https://raw.github.com/gist/125aa788d32f14ecad61/3a09ccc5398f0d319084be68e554f00587886248/sabnzbd.ini'
  destination '~/Library/Application Support/SABnzbd/sabnzbd.ini'
  arguments ({
    '$SABNZBD_USERNAME' => var(:sabnzbd_username),
    '$SABNZBD_PASSWORD' => var(:sabnzbd_password),
    '$SABNZBD_API_KEY' => var(:sabnzbd_api_key),
    '$SABNZBD_NZB_KEY' => var(:sabnzbd_nzb_key),
    '$NZBMATRIX_USERNAME' => var(:nzbmatrix_username),
    '$NZBMATRIX_API_KEY' => var(:nzbmatrix_api_key),
    '$USENET_HOST' => var(:usenet_host),
    '$USENET_PORT' => var(:usenet_port),
    '$USENET_USERNAME' => var(:usenet_username),
    '$USENET_PASSWORD' => var(:usenet_password),
    '$USENET_NUM_CONNECTIONS' => var(:usenet_num_connections),
    '$USENET_USE_SSL' => var(:usenet_use_ssl)
    })
end
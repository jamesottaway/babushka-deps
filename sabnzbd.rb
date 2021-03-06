require 'securerandom'

dep 'SABnzbd.app' do
  source 'http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/sabnzbd-0.6.9/SABnzbd-0.6.9-osx-lion.dmg?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsabnzbdplus%2Ffiles%2Fsabnzbdplus%2Fsabnzbd-0.6.9%2F&ts=1316039666&use_mirror=internode'
  requires_when_unmet 'SABnzbd-launchctl.template', 'SABnzbd-config.template'
end

dep 'SABnzbd-launchctl.template' do
  set :sabnzbd_label, 'com.sabnzbd.sabnzbd'
  set :sabnzbd_app, var(:sabnzbd_home)
  set :sabnzbd_binary, 'SABnzbd'
  template 'https://gist.github.com/raw/fff0bc9d4ca201d7dfd3/2fa887550afe6cae5a3978405c427d0b39985281/com.app.app.plist'
  destination '~/Library/LaunchAgents/com.sabnzbd.sabnzbd.plist'
  arguments ({ '$LABEL' => var(:sabnzbd_label), '$APP' => var(:sabnzbd_app).to_s, '$BINARY' => var(:sabnzbd_binary) })
  after { shell 'launchctl load ~/Library/LaunchAgents/com.sabnzbd.sabnzbd.plist' }
end

dep 'SABnzbd-config.template' do
  define_var :sabnzbd_username, :message => 'SABnzbd Username', :default => 'admin'
  define_var :sabnzbd_password, :message => 'SABnzbd Password'
  define_var :sabnzbd_api_key, :message => 'SABnzbd API Key', :default => SecureRandom.hex
  define_var :sabnzbd_nzb_key, :message => 'SABnzbd NZB Key', :default => SecureRandom.hex
  define_var :sabnzbd_http_port, :message => 'SABnzbd HTTP Port', :default => '8080'
  define_var :sabnzbd_https_port, :message => 'SABnzbd HTTPS Port', :default => '9090'
  define_var :sabnzbd_pending_downloads_dir, :message => 'SABnzbd Pending Downloads Dir'
  define_var :sabnzbd_complete_downloads_dir, :message => 'SABnzbd Complete Downloads Dir'
  define_var :nzbmatrix_username, :message => 'NZBMatrix Username'
  define_var :nzbmatrix_api_key, :message => 'NZBMatrix API Key'
  define_var :usenet_host, :message => 'Usenet Host'
  define_var :usenet_port, :message => 'Usenet Port'
  define_var :usenet_username, :message => 'Usenet Username'
  define_var :usenet_password, :message => 'Usenet Password'
  define_var :usenet_connections_limit, :message => 'Usenet Connections Limit'
  define_var :usenet_use_ssl, :message => 'Usenet SSL?', :choice_descriptions => { '1' => 'Yes', '0' => 'No' }
  define_var :usenet_retention, :message => 'Usenet Retention'
  
  template 'https://gist.github.com/raw/125aa788d32f14ecad61/6a3261b0b5d36a79b47e771a6c47e5bb764948c3/sabnzbd.ini'
  destination '~/Library/Application Support/SABnzbd/sabnzbd.ini'
  
  arguments ({
    '$SABNZBD_USERNAME' => var(:sabnzbd_username),
    '$SABNZBD_PASSWORD' => var(:sabnzbd_password),
    '$SABNZBD_API_KEY' => var(:sabnzbd_api_key),
    '$SABNZBD_NZB_KEY' => var(:sabnzbd_nzb_key),
    '$SABNZBD_HTTP_PORT' => var(:sabnzbd_http_port),
    '$SABNZBD_HTTPS_PORT' => var(:sabnzbd_https_port),
    '$SABNZBD_PENDING_DOWNLOADS_DIR' => var(:sabnzbd_pending_downloads_dir),
    '$SABNZBD_COMPLETE_DOWNLOADS_DIR' => var(:sabnzbd_complete_downloads_dir),
    '$NZBMATRIX_USERNAME' => var(:nzbmatrix_username),
    '$NZBMATRIX_API_KEY' => var(:nzbmatrix_api_key),
    '$USENET_HOST' => var(:usenet_host),
    '$USENET_PORT' => var(:usenet_port),
    '$USENET_USERNAME' => var(:usenet_username),
    '$USENET_PASSWORD' => var(:usenet_password),
    '$USENET_CONNECTIONS_LIMIT' => var(:usenet_connections_limit),
    '$USENET_USE_SSL' => var(:usenet_use_ssl),
    '$USENET_RETENTION' => var(:usenet_retention)
    })
end

dep 'SABnzbd' do
  set :sabnzbd_home, '/Applications/SABnzbd.app'
  requires 'SABnzbd.app'
end
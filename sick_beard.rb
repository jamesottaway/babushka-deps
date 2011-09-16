dep 'cheetah' do
  met? { '/usr/local/bin/cheetah'.to_fancypath.exists? }
  meet {
    handle_source 'http://pypi.python.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz#md5=853917116e731afbc8c8a43c37e6ddba' do |tarball|
      in_build_dir do |build_dir|
        cheetah_dir = (build_dir / tarball.path.basename).children.first
        cd cheetah_dir do
          sudo 'python setup.py install'
        end
      end
    end
  }
end

dep 'SickBeard.app' do
  requires 'cheetah'
  met? { var(:sickbeard_home).exists? && !var(:sickbeard_home).empty? }
  meet {
    handle_source 'git://github.com/midgetspy/Sick-Beard.git' do |repo|
      in_build_dir do |build_dir|
        app = build_dir / repo.basename
        app.copy var(:sickbeard_home)
      end
    end
  }
end

dep 'SickBeard-launchctl.template' do
  requires 'SickBeard.app'
  template 'https://gist.github.com/raw/aa2d7431902f39803524/c8d0ebca6974e7d16aa5e53670f7e6992f8080a0/com.sickbeard.sickbeard.plist'
  destination '~/Library/LaunchAgents/com.sickbeard.sickbeard.plist'
  arguments ({ '$SICKBEARD_HOME' => var(:sickbeard_home).to_s })
  after {
    shell 'launchctl load ~/Library/LaunchAgents/com.sickbeard.sickbeard.plist'
    shell 'launchctl start com.sickbeard.sickbeard.plist'
  }
end

dep 'SickBeard-config.template' do
  requires 'SickBeard.app'
  
  define_var :sickbeard_username, :message => 'Sick Beard Username', :default => 'admin'
  define_var :sickbeard_password, :message => 'Sick Beard Password'
  define_var :sickbeard_http_port, :message => 'Sick Beard HTTP Port', :default => '8081'
  define_var :sabnzbd_username, :message => 'SABnzbd Username', :default => 'admin'
  define_var :sabnzbd_password, :message => 'SABnzbd Password'
  define_var :sabnzbd_host, :message => 'SABnzbd Host', :default => 'locahost'
  define_var :sabnzbd_port, :message => 'SABnzbd Port', :default => '8080'
  define_var :sabnzbd_api_key, :message => 'SABnzbd API Key'
  define_var :sabnzbd_complete_downloads_dir, :message => 'Where does SABnzbd store completed downloads?'
  define_var :nzbmatrix_username, :message => 'NZBMatrix Username'
  define_var :nzbmatrix_api_key, :message => 'NZBMatrix API Key'
  define_var :usenet_retention, :message => 'Usenet Retention'
  define_var :twitter_username_token, :message => 'Twitter Username Token'
  define_var :twitter_password_token, :message => 'Twitter Password Token'
  
  template 'https://gist.github.com/raw/7a03b77a9b3e008e8b16/1c8b5b07ebddc4b1cdff14468b63ca0f16dc46d3/sickbeard.ini'
  destination '/Applications/SickBeard/config.ini'
  
  arguments ({
    '$SICKBEARD_USERNAME' => var(:sickbeard_username),
    '$SICKBEARD_PASSWORD' => var(:sickbeard_password),
    '$SICKBEARD_HTTP_PORT' => var(:sickbeard_http_port),
    '$SABNZBD_USERNAME' => var(:sabnzbd_username),
    '$SABNZBD_PASSWORD' => var(:sabnzbd_password),
    '$SABNZBD_HOST' => var(:sabnzbd_host),
    '$SABNZBD_PORT' => var(:sabnzbd_port),
    '$SABNZBD_API_KEY' => var(:sabnzbd_api_key),
    '$SABNZBD_COMPLETE_DOWNLOADS_DIR' => var(:sabnzbd_complete_downloads_dir),
    '$NZBMATRIX_USERNAME' => var(:nzbmatrix_username),
    '$NZBMATRIX_API_KEY' => var(:nzbmatrix_api_key),
    '$USENET_RETENTION' => var(:usenet_retention),
    '$TWITTER_USERNAME_TOKEN' => var(:twitter_username_token),
    '$TWITTER_PASSWORD_TOKEN' => var(:twitter_password_token)
    })
end

dep 'SickBeard' do
  set :sickbeard_home, '/Applications/SickBeard'.to_fancypath
  requires 'SABnzbd', 'SickBeard-launchctl.template', 'SickBeard-config.template'
end
dep 'SABnzbd.app' do
  source 'http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/sabnzbd-0.6.9/SABnzbd-0.6.9-osx-lion.dmg?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsabnzbdplus%2Ffiles%2Fsabnzbdplus%2Fsabnzbd-0.6.9%2F&ts=1316039666&use_mirror=internode'
end

dep 'SABnzbd.app', :for => :snow_leopard do
  source 'http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/sabnzbd-0.6.9/SABnzbd-0.6.9-osx.dmg?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsabnzbdplus%2Ffiles%2Fsabnzbdplus%2Fsabnzbd-0.6.9%2F&ts=1316039619&use_mirror=internode'
end

dep 'SABnzbd.launchagent' do
  requires 'SABnzbd.app'
  define_var :sabnzbd_app, :default => '/Applications/SABnzbd.app', :message => 'Where does SABnzbd.app live?'
  plist 'com.sabnzbd.sabnzbd.plist'
  source 'https://raw.github.com/gist/a7a12e5d301fd1d0d6e6/a39890035a298a4bdf0d29d40065b6ceba1e1254/com.sabnzbd.sabnzbd.plist'
  arguments ({ '$SABNZBD_APP' => var(:sabnzbd_app) })
end
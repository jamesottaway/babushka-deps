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

dep 'SickBeard' do
  requires 'cheetah'
  destination = '/Applications'.to_fancypath / name
  met? { destination.exists? && !destination.empty? }
  meet {
    handle_source 'git://github.com/midgetspy/Sick-Beard.git' do |repo|
      in_build_dir do |build_dir|
        app = build_dir / repo.basename
        app.copy destination
      end
    end
  }
end

dep 'SickBeard launchagent' do
  requires 'SickBeard'
  define_var :sickbeard_home, :default => '/Applications/SickBeard', :message => 'Where does Sick Beard live?'
  config = 'https://raw.github.com/gist/aa2d7431902f39803524/303c5bd3713b9ffec537834ef598481f0c39baac/com.sickbeard.sickbeard.plist'
  launch_agents = '~/Library/LaunchAgents'.to_fancypath
  plist = launch_agents / 'com.sickbeard.sickbeard.plist'
  met? { plist.exists? && plist.read[var :sickbeard_home] }
  meet {
    Babushka::Resource.get config do |conf|
      conf.copy plist
    end
    shell "sed -i '' 's~$SICKBEARD_HOME~#{var :sickbeard_home}~g' #{plist}"
  }
end
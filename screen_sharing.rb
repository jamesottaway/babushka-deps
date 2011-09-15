dep 'vnc password configured' do
  settings = '/Library/Preferences/com.apple.VNCSettings.txt'
  password = '645D301BE0C1B0D3FF1C39567390ADCA'
  met? { sudo("cat #{settings}") == password }
  meet { sudo "echo '#{password}' > #{settings}" }
end

dep 'screen sharing enabled' do
  met? { sudo('launchctl list')['com.apple.screensharing'] }
  meet { sudo 'launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist' }
end

dep 'ScreenSharing' do
  requires 'vnc password configured', 'screen sharing enabled'
end
dep 'vnc password configured' do
  settings = '/Library/Preferences/com.apple.VNCSettings.txt'
  password = '645D301BE0C1B0D3FF1C39567390ADCA'
  met? { sudo("cat #{settings}") == password }
  meet { sudo "echo '#{password}' > #{settings}" }
end

dep 'ScreenSharing.launchctl' do
  label 'com.apple.screensharing'
  plist '/System/Library/LaunchDaemons/com.apple.screensharing.plist'
end

dep 'Screen Sharing' do
  requires 'vnc password configured', 'ScreenSharing.launchctl'
end
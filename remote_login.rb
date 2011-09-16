dep 'RemoteLogin.launchctl' do
  label 'com.openssh.sshd'
  plist '/System/Library/LaunchDaemons/ssh.plist'
end

dep 'RemoteLogin' do
  requires 'RemoteLogin.launchctl'
end
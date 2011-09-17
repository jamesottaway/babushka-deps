dep 'RemoteLogin.launchctl' do
  label 'com.openssh.sshd'
  plist '/System/Library/LaunchDaemons/ssh.plist'
end

dep 'Remote Login' do
  requires 'RemoteLogin.launchctl'
end
dep 'RemoteLogin' do
  met? { sudo('launchctl list')['com.openssh.sshd'] }
  meet { sudo 'launchctl load -w /System/Library/LaunchDaemons/ssh.plist' }
end
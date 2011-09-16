meta :launchctl do
  accepts_value_for :label
  accepts_value_for :plist
  template {
    met? { sudo('launchctl list')[label] }
    meet { sudo "launchctl load -w #{plist}" }
  }
end
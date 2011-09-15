meta :launchagent do
  accepts_value_for :plist
  accepts_value_for :source
  accepts_value_for :arguments
  
  launch_agents = '~/Library/LaunchAgents'.to_fancypath
  
  template {
    setup {
      @plist = launch_agents / plist
      @values = arguments.map(&:last)
    }
    met? { @plist.exists? && @values.all? { |value| @plist.read[value] } }
    meet {
      Babushka::Resource.get source do |config|
        config.copy @plist
      end
      arguments.each do |argument|
        shell "sed -i '' 's~#{argument.first}~#{argument.last}~g' #{@plist}"
      end
    }
    after {
      shell "launchctl load #{@plist}"
      shell "launchctl start #{plist}"
    }
  }
end
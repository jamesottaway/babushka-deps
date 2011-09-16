meta :template do
  accepts_value_for :template
  accepts_value_for :destination
  accepts_value_for :arguments
  
  template {
    setup {
      @destination = destination.to_fancypath
      @settings = arguments.map(&:last)
    }
    met? { @destination.exists? && @settings.all? { |setting| @destination.read[setting] } }
    meet {
      Babushka::Resource.get template do |file|
        file.copy @destination
        arguments.map do |argument|
          shell "sed -i '' 's%#{argument.first}%#{argument.last}%g' '#{@destination}'"
        end
      end
    }
  }
end
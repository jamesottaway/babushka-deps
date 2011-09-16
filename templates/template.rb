meta :template do
  accepts_value_for :source
  accepts_value_for :destination
  accepts_value_for :arguments
  
  template {
    setup {
      @destination = destination.to_fancypath
      @settings = arguments.map(&:last)
    }
    met? { @destination.exists? && @settings.all? { |setting| @destination.read[setting] } }
    meet {
      Babushka::Resource.get source do |file|
        arguments.each do |argument|
          shell "sed -i '' 's%#{argument.first}%#{argument.last}%g' '#{file}'"
        end
        file.copy @destination
      end
    }
  }
end
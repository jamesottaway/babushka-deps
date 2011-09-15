meta :gist do
  accepts_value_for :source
  accepts_value_for :destination
  accepts_value_for :arguments
  
  template {
    setup {
      @destination = destination.to_fancypath
      @values = arguments.map(&:last)
    }
    met? { @destination.exists? && @values.all? { |value| @destination.read[value] } }
    meet {
      Babushka::Resource.get source do |file|
        file.copy @destination
      end
      arguments.each do |argument|
        shell "sed -i '' 's~#{argument.first}~#{argument.last}~g' '#{@destination}'"
      end
    }
  }
end
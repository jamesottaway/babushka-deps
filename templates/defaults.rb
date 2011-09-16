meta :defaults do
  accepts_value_for :domain
  accepts_value_for :key
  accepts_value_for :type
  accepts_value_for :value
  accepts_value_for :global?
  
  template {
    global = 'NSGlobalDomain'
    setup { @key = key || name }
    met? { shell("defaults read #{global? ? global : ''} #{domain} #{@key}") == value }
    meet { shell "defaults write #{global? ? global : ''} #{domain} #{@key} -#{type} #{value}" }
  }
end
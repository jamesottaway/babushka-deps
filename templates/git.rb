meta :cloned do
  accepts_value_for :repo
  accepts_value_for :destination
  
  template {
    met? { destination.to_fancypath.exists? && shell("(cd #{destination} && git remote -v)")[repo] }
    meet { shell "git clone #{repo} #{destination}" }
  }
end
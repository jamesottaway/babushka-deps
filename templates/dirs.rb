meta :clean do
  accepts_value_for :clean
  template {
    met? { cd(clean) { |path| path.children.empty? } }
    meet { cd(clean) { |path| path.children.each { |child| sudo "rm -rf #{child}" } } }
  }
end
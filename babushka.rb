dep 'build dir clean' do
  met? { in_build_dir { |path| path.children.empty? } }
  meet { in_build_dir { |path| path.children.each { |child| sudo "rm -rf #{child}" } } }
end

dep 'download dir clean' do
  met? { in_download_dir { |path| path.children.empty? } }
  meet { in_download_dir { |path| path.children.each { |child| sudo "rm -rf #{child}" } } }
end
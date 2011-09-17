dep 'build.clean' do
  clean in_build_dir {|path| path}
end

dep 'downloads.clean' do
  clean in_download_dir {|path| path}
end
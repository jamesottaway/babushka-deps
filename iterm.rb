dep 'iTerm.app' do
  meet {
    handle_source 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip' do |zip|
      in_build_dir do |path|
        app = path / zip.path.without_extension.basename / 'iTerm.app'
        app.copy '/Applications'
      end
    end
  }
end
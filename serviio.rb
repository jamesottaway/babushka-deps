dep 'Serviio.app' do
  meet do
    handle_source 'http://download.serviio.org/releases/serviio-0.6.0.1-osx.tar.gz' do |p|
      in_build_dir do |build_dir|
        (build_dir / p.name / name).copy '/Applications'
      end
    end
  end
end

dep 'Serviio-Console.app' do
  meet do
    handle_source 'http://download.serviio.org/releases/serviio-0.6.0.1-osx.tar.gz' do |p|
      in_build_dir do |build_dir|
        (build_dir / p.name / name).copy '/Applications'
      end
    end
  end
end
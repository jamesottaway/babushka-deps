dep 'CouchPotato' do
  destination = '/Applications'.to_fancypath / name
  met? { destination.exists? && !destination.empty? }
  meet {
    handle_source 'git://github.com/RuudBurger/CouchPotato.git' do |repo|
      in_build_dir do |build_dir|
        app = build_dir / repo.basename
        app.copy destination
      end
    end
  }
end
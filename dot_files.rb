dep 'dot files.cloned' do
  repo 'git@github.com:jamesottaway/dot-files.git'
  destination '~/.dot-files'
end

dep 'dot files symlinked' do
  requires 'dot files.cloned'
  
  def home_dir
    '~'.to_fancypath
  end
  
  def dot_files
    (home_dir / '.dot-files').all_children
  end
  
  def missing_dot_files
    dot_files.select { |d|
      (home_dir / d.basename).readlink != d
    }.reject { |d| d.basename == '.git' }
  end
  
  met? { missing_dot_files.empty? }
  before {
    missing_dot_files.map { |d|
      home_dir / d.basename
    }.select { |d|
      d.exists?
    }.map { |d|
      d.remove
    }
  }
  meet {
    missing_dot_files.map { |d| shell "ln -s #{d} #{home_dir}" }
  }
end

dep 'dot files' do
  requires 'dot files symlinked'
end
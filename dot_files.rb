dep 'dot files.cloned' do
  repo 'git@github.com:jamesottaway/dot-files.git'
  destination '~/.dot-files'
end

dep 'dot files symlinked' do
  requires 'dot files.cloned'
  
  def dot_files
    '~/.dot-files'.to_fancypath.all_children.reject { |dot_file| dot_file.basename == '.git' }.map { |dot_file| DotFile.new dot_file }
  end
  
  def missing_dot_files
    dot_files.select { |dot_file| dot_file.destination.readlink != dot_file.source }
  end
  
  def pre_symlink_cleanup
    missing_dot_files.map(&:destination).select { |destination| destination.exists? }.map { |destination| destination.remove }
  end
  
  met? { missing_dot_files.empty? }
  before { pre_symlink_cleanup }
  meet { missing_dot_files.map { |d| shell "ln -s #{d.source} #{d.destination}" } }
end

dep 'dot files' do
  requires 'dot files symlinked'
end

class DotFile < Struct.new(:source, :destination)
  def initialize source
    self.source, self.destination = source, to_destination(source)
  end
  
  def to_destination source
    '~'.to_fancypath / source.basename.to_s.gsub('@', '/')
  end
end
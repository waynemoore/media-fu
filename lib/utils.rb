require 'parser'

def parse_file_names path
  glob = File.join(path, '**/*')
  media_data = []
  Dir.glob(glob).each do |file_path|
    fn = File.basename file_path
    metadata = parse(fn)
    media_data << { :path => file_path }.merge(metadata) if metadata
  end
  media_data
end

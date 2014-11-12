require 'fog'

module AllSeeingPi
  class Uploader
    DIRECTORY_PREFIX = 'all-seeing-pi'

    attr_reader :client

    def initialize
      @client = Fog::Storage.new(
        provider: 'AWS',
        aws_access_key_id: AllSeeingPi.config[:aws_key],
        aws_secret_access_key: AllSeeingPi.config[:aws_secret]
      )
    end

    def upload(image_path)
      directories = client.directories

      directory_name = fetch_or_create_directory_name(directories)
      directory = directories.get(directory_name) || directories.create(key: directory_name)

      filename = File.basename(image_path)
      directory.files.create(key: filename, body: File.open(image_path))
    end

    def fetch_or_create_directory_name(directories)
      directory_name = directories.map do |directory|
        key = directory.key
        key if key.match /all_seeing_pi/
      end.compact.first

      AllSeeingPi.config[:directory_name] ||= "#{DIRECTORY_PREFIX}-#{directory_id}"
    end

    def directory_id
      Time.now.to_f.to_s.split('.').join.to_i
    end
  end
end

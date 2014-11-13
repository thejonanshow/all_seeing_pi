require 'all_seeing_pi/camera'
require 'all_seeing_pi/uploader'
require 'phashion'
require 'httparty'

module AllSeeingPi
  class Golem
    attr_reader :camera, :uploader

    def initialize
      @camera = AllSeeingPi::Camera.new
      @uploader = AllSeeingPi::Uploader.new
    end

    def spy
      image_path = @camera.capture
      return unless File.exists?(image_path)

      AllSeeingPi.report "Captured #{image_path}"

      url = store_image(image_path)
      phash = get_phash(image_path)
      send_to_palantir(image_path, phash, url)

      FileUtils.rm(image_path)
    end

    def get_phash(image_path)
      Phashion::Image.new(image_path).fingerprint
    end

    def store_image(image_path)
      @uploader.upload(image_path)
    end

    def send_to_palantir(image_path, phash, url)
      data = {
        :name => File.basename(image_path),
        :phash => phash,
        :url => url,
        :directory_name => AllSeeingPi.config[:directory_name]
      }

      HTTParty.post(
        "#{AllSeeingPi.config[:palantir_url]}/api/images",
        :query => { :image => data },
        :headers => { 'Authorization' => AllSeeingPi.config[:palantir_api_key] }
      )

      AllSeeingPi.report "Sent to Palantir - name: #{data[:name]}, phash: #{data[:phash]}, directory: #{data[:directory_name]}"
    end
  end
end

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

      report "Captured #{image_path}"

      store_image(image_path)
      phash = get_phash(image_path)
      send_to_palantir(image_path, phash)

      FileUtils.rm(image_path)
    end

    def get_phash(image_path)
      Phashion::Image.new(image_path).fingerprint
    end

    def report(msg)
      puts msg unless ENV['ALL_SEEING_PI_ENV'] == 'test'
    end

    def store_image(image_path)
      @uploader.upload(image_path)
    end

    def send_to_palantir(image_path, phash)
      data = {
        :name => File.basename(image_path),
        :phash => phash,
        :directory_name => AllSeeingPi.config[:directory_name]
      }.to_json

      HTTParty.post(
        AllSeeingPi.config[:palantir_url],
        data
      )
    end
  end
end

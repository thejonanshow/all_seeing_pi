require 'all_seeing_pi/camera'
require 'all_seeing_pi/uploader'
require 'phashion'

module AllSeeingPi
  class Palantir
    attr_reader :camera, :uploader

    def initialize
      @camera = AllSeeingPi::Camera.new
      @uploader = AllSeeingPi::Uploader.new
    end

    def spy
      image_path = @camera.capture
      return unless File.exists?(image_path)
      image_phash = phash(image_path)

      puts "Captured #{image_path} with phash #{image_phash}"

      store_image(image_path)
      FileUtils.rm(image_path)
      # tell sauron phash and url of image
    end

    def phash(image_path)
      Phashion::Image.new(image_path).fingerprint
    end

    def store_image(image_path)
      @uploader.upload(image_path)
    end
  end
end

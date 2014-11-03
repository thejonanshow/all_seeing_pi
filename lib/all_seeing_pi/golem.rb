require 'all_seeing_pi/camera'
require 'all_seeing_pi/uploader'

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
      FileUtils.rm(image_path)
    end

    def report(msg)
      puts msg unless ENV['ALL_SEEING_PI_ENV'] == 'test'
    end

    def store_image(image_path)
      @uploader.upload(image_path)
    end
  end
end

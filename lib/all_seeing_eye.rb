require 'camera'
require 'uploader'

class AllSeeingEye
  attr_reader :camera, :uploader

  def initialize
    @camera = Camera.new
    @uploader = Uploader.new
  end

  def spy
    image_path = @camera.capture
    image_phash = phash(image_path)
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

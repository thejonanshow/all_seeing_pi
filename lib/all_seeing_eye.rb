require 'camera'

class AllSeeingEye
  attr_reader :camera

  def initialize
    @camera = Camera.new
  end

  def spy
    image_path = @camera.capture
    phash(image_path)
    # push picture to s3
    # delete picture locally
    # tell sauron phash and url of image
  end

  def phash(image_path)
    Phashion::Image.new(image_path).fingerprint
  end
end

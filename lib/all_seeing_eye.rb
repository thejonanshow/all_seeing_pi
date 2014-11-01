require 'camera'

class AllSeeingEye
  attr_reader :camera

  def initialize
    @camera = Camera.new
  end

  def spy
    # take picture
    # get phash of picture
    # push picture to s3
    # delete picture locally
    # tell sauron phash and url of image
  end
end

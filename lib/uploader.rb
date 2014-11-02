require 'aws-sdk'

class Uploader
  BUCKET = 'all_seeing_eye'

  attr_reader :s3

  def initialize
    @s3 = AWS::S3.new
  end

  def upload(image_path)
    buckets = s3.buckets
    buckets.create(BUCKET) unless buckets[BUCKET].exists?

    filename = File.basename(image_path)
    buckets[BUCKET].objects[filename].write(:file => image_path)
  end
end

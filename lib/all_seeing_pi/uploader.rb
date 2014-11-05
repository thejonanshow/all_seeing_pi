require 'aws-sdk'

module AllSeeingPi
  class Uploader
    BUCKET_PREFIX = 'all_seeing_pi'

    attr_reader :s3

    def initialize
      @s3 = AWS::S3.new
      require 'pry'; binding.pry if $debug
    end

    def upload(image_path)
      buckets = s3.buckets

      bucket_name = fetch_or_create_bucket_name(buckets)
      buckets.create(bucket_name) unless buckets[bucket_name].exists?

      filename = File.basename(image_path)
      buckets[bucket_name].objects[filename].write(:file => image_path)
    end

    def fetch_or_create_bucket_name(buckets)
      bucket_name = buckets.map do |bucket|
        name = bucket.name
        name if name.match /all_seeing_pi/
      end.compact.first

      bucket_name ||= "#{BUCKET_PREFIX}_#{bucket_id}"
    end

    def bucket_id
      Time.now.to_f.to_s.split('.').join.to_i
    end
  end
end

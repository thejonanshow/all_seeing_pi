require 'test_helper'
require 'json'

class GollumTest < MiniTest::Unit::TestCase
  def setup
    Fog.mock!
    AllSeeingPi.config.load_config_from_file('test/all_seeing_pi.yml')

    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @filename = File.basename(@fixture)
    @golem = AllSeeingPi::Gollum.new
    @phash = @golem.get_phash(@fixture)
    @palantir_url = 'http://all-seeing-pi.com/api/images'
    @public_url = 'http://public-url.com'

    @image_data = {
      :name => @filename,
      :phash => @phash,
      :url => @public_url,
      :directory_name => AllSeeingPi.config[:directory_name]
    }
    @token = AllSeeingPi.config[:palantir_access_token]
  end

  def test_spy_sends_capture_to_the_camera
    @golem.stubs(:store_image)
    FileUtils.stubs(:rm)
    HTTParty.stubs(:post)

    @golem.camera.expects(:capture).returns(@fixture)
    @golem.spy
  end

  def test_store_image
    @golem.camera.stubs(:capture).returns(@fixture)
    FileUtils.stubs(:rm)
    HTTParty.stubs(:post)

    @golem.uploader.expects(:upload).with(@fixture)
    @golem.spy
  end

  def test_spy_deletes_the_image
    @golem.camera.stubs(:capture).returns(@fixture)
    @golem.stubs(:store_image)
    HTTParty.stubs(:post)

    FileUtils.expects(:rm).with(@fixture)
    @golem.spy
  end

  def test_spy_calculates_the_phash
    @golem.camera.stubs(:capture).returns(@fixture)
    FileUtils.stubs(:rm)
    HTTParty.stubs(:post)

    image = mock(:fingerprint)
    Phashion::Image.expects(:new).with(@fixture).returns(image)
    @golem.spy
  end

  def test_spy_sends_palantir_the_image_details
    @golem.camera.stubs(:capture).returns(@fixture)
    @golem.stubs(:store_image).returns(@public_url)
    FileUtils.stubs(:rm)
    HTTParty.stubs(:post)

    @golem.expects(:send_to_palantir).with(@fixture, @phash, @public_url)
    @golem.spy
  end

  def test_send_to_palantir_uses_uri_from_config
    HTTParty.expects(:post).with( @palantir_url, { :query => { :image => @image_data, :access_token => @token } } )
    @golem.send_to_palantir(@fixture, @phash, @public_url)
  end

  def test_send_to_palantir_posts_the_image_data
    HTTParty.expects(:post).with( @palantir_url, { :query => { :image => @image_data, :access_token => @token } } )
    @golem.send_to_palantir(@fixture, @phash, @public_url)
  end
end

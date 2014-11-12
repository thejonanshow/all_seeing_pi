require 'test_helper'
require 'json'

class GolemTest < MiniTest::Unit::TestCase
  def setup
    Fog.mock!
    AllSeeingPi.config.load_config_from_file('test/all_seeing_pi.yml')

    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @filename = File.basename(@fixture)
    @golem = AllSeeingPi::Golem.new
    @phash = @golem.get_phash(@fixture)

    @image_json = {
      :name => @filename,
      :phash => @phash,
      :directory_name => AllSeeingPi.config[:directory_name]
    }.to_json
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
    FileUtils.stubs(:rm)
    HTTParty.stubs(:post)

    @golem.expects(:send_to_palantir).with(@fixture, @phash)
    @golem.spy
  end

  def test_send_to_palantir_uses_uri_from_config
    AllSeeingPi.config[:palantir_url] = 'http://totallyrealurl.com'
    HTTParty.expects(:post).with('http://totallyrealurl.com', @image_json)
    @golem.send_to_palantir(@fixture, @phash)
  end

  def test_send_to_palantir_posts_the_image_data
    AllSeeingPi.config[:palantir_url] = 'http://totallyrealurl.com'

    HTTParty.expects(:post).with(
      'http://totallyrealurl.com',
      @image_json
    )
    @golem.send_to_palantir(@fixture, @phash)
  end
end

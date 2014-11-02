require 'test_helper'
require 'all_seeing_eye'

class AllSeeingEyeTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @eye = AllSeeingEye.new
  end

  def test_spy_sends_capture_to_the_camera
    @eye.stubs(:phash)
    @eye.stubs(:store_image)
    FileUtils.stubs(:rm)

    @eye.camera.expects(:capture)
    @eye.spy
  end

  def test_phash
    phash = @eye.phash(@fixture)
    assert_equal 8540390173105289264, phash
  end

  def test_spy_gets_phash_of_image
    @eye.camera.stubs(:capture).returns('one_ring.jpg')
    @eye.stubs(:store_image)
    FileUtils.stubs(:rm)
    Phashion::Image.stubs(:new)

    @eye.expects(:phash).with('one_ring.jpg')
    @eye.spy
  end

  def test_store_image
    @eye.camera.stubs(:capture).returns(@fixture)
    FileUtils.stubs(:rm)

    @eye.uploader.expects(:upload).with(@fixture)
    @eye.spy
  end

  def test_spy_deletes_the_image
    @eye.camera.stubs(:capture).returns('one_ring.jpg')
    @eye.stubs(:phash)
    @eye.stubs(:store_image)

    FileUtils.expects(:rm).with('one_ring.jpg')
    @eye.spy
  end
end

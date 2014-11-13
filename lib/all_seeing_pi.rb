require "all_seeing_pi/version"
require "all_seeing_pi/golem"
require "all_seeing_pi/camera"
require "all_seeing_pi/uploader"
require "all_seeing_pi/configuration"

module AllSeeingPi
  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  def self.watch
    golem = AllSeeingPi::Golem.new

    loop do
      golem.spy
    end
  end

  def self.report(msg)
    puts msg unless ENV['ALL_SEEING_PI_ENV'] == 'test'
  end
end

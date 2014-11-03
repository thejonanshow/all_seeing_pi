require "all_seeing_pi/version"
require "all_seeing_pi/golem"
require "all_seeing_pi/camera"
require "all_seeing_pi/uploader"

module AllSeeingPi
  def self.watch
    golem = AllSeeingPi::Golem.new

    loop do
      golem.spy
    end
  end
end

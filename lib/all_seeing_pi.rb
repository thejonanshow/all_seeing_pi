require "all_seeing_pi/version"
require "all_seeing_pi/palantir"
require "all_seeing_pi/camera"
require "all_seeing_pi/uploader"

module AllSeeingPi
  def self.watch
    palantir = AllSeeingPi::Palantir.new

    loop do
      palantir.spy
    end
  end
end

module AllSeeingPi
  class Camera
    attr_reader :script

    def initialize
      @script = File.expand_path('../../../capture.sh', __FILE__)
    end

    def capture
      `#{script}`.strip
    end
  end
end

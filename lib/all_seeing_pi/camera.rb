module AllSeeingPi
  class Camera
    attr_reader :script

    def initialize
      path = '../../../capture.sh'
      @script = AllSeeingPi.config[:capture_script] || File.expand_path(path, __FILE__)
    end

    def capture
      `#{script}`.strip
    end
  end
end

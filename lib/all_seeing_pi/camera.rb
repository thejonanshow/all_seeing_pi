module AllSeeingPi
  class Camera
    def capture
      `./capture.sh`.strip
    end
  end
end

module AllSeeingPi
  class Configuration
    attr_accessor :aws_key, :aws_secret, :palantir_url, :directory_name, :capture_script

    def initialize
      reset!
      load_config_from_file
    end

    def reset!
      instance_variables.each do |var|
        instance_variable_set(var, nil)
      end
    end

    def [](key)
      send(key)
    end

    def []=(key, value)
      send("#{key}=", value)
    end

    def load_config_from_file(filename = 'all_seeing_pi.yml')
      paths = [
        "#{filename}",
        "config/#{filename}"
      ]

      config = {}

      paths.each do |filepath|
        config = YAML.load_file(filepath) if File.exists?(filepath)
      end

      config.each do |key, value|
        send("#{key}=", value)
      end
    end
  end
end

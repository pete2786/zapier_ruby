module ZapierRuby
  class Config
    attr_accessor :base_uri, :web_hooks, :enable_logging, :logger

    def initialize
      self.base_uri = "https://zapier.com/hooks/catch/"
      self.web_hooks = { example_webhook: "webhook_id" }
      self.enable_logging = true
      self.logger = Logger.new(STDOUT)
    end

    def configure_with(path_to_yaml_file)
      begin
        config_yaml = YAML::load(IO.read(path_to_yaml_file))
        reconfigure(config_yaml)
      rescue Exception => e
        logger.error "YAML configuration file cannot be loaded. Using defaults. Error :#{e.message}"
        return
      end
    end

    def reconfigure(config = {})
      config.keys.select{|k| respond_to?("#{k}=")}.each{|k| self.send("#{k}=", config[k])}
    end
  end
end

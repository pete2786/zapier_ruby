module ZapierRuby
  class Config
    attr_accessor :base_url, :web_hooks, :enable_logging

    def initialize
      self.base_url = config_hash[:base_url] || nil
      self.web_hooks = config_hash[:web_hooks] || {}
      self.enable_logging = config_hash[:enable_logging].present? ? config_hash[:enable_logging] : false
    end

    def config_hash
      @config_hash ||= Hash[config_yaml.map{|(k,v)| [k.to_sym,v]}]
    end

    def config_yaml
      YAML.load_file(config_yaml_path)
    end
    private :config_yaml

    def config_yaml_path 
      File.join(File.dirname(__FILE__), 'config', 'zapier_ruby.yml')
    end
    private :config_yaml_path

    def logger
      @logger ||= ZapierRuby::LoggerDecorator.new(enable_logging)
    end
    private :logger
  end
end
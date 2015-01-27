require 'rest_client'
require 'yaml'
require 'delegate'
require 'logger'

require 'zapier_ruby/version'
require 'zapier_ruby/logger_decorator'
require 'zapier_ruby/config'
require 'zapier_ruby/zapper'

module ZapierRuby
  @config = {
    base_url: "https://zapier.com/hooks/catch/",
    enable_logging: true,
    web_hooks: { example_webhook: "webhook_id" },
  }

  @valid_config_keys = @config.keys

  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      log(:warning, "YAML configuration file couldn't be found. Using defaults."); return
    rescue Psych::SyntaxError
      log(:warning, "YAML configuration file contains invalid syntax. Using defaults."); return
    end

    configure(config)
  end

  def self.config
    @config
  end
end

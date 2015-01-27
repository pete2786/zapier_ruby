require 'rest_client'
require 'yaml'
require 'delegate'
require 'logger'

require 'zapier_ruby/version'
require 'zapier_ruby/logger_decorator'
require 'zapier_ruby/config'
require 'zapier_ruby/zapper'

module ZapierRuby
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= ZapierRuby::Config.new
    yield(config) if block_given?
  end

    def configure_with(config = {})
      self.config ||= ZapierRuby::Config.new

      begin
        config_yaml = YAML::load(IO.read(path_to_yaml_file))
      rescue Errno::ENOENT
        log(:warning, "YAML configuration file couldn't be found. Using defaults.")
        return
      rescue Psych::SyntaxError
        log(:warning, "YAML configuration file contains invalid syntax. Using defaults.")
        return
      end

      config.configure_with(config_yaml)
    end
end

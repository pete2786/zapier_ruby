require 'rest_client'
require 'yaml'
require 'delegate'
require 'logger'

require 'zapier_ruby/version'
require 'zapier_ruby/exceptions'
require 'zapier_ruby/logger_decorator'
require 'zapier_ruby/config'
require 'zapier_ruby/base'
require 'zapier_ruby/zapper'
require 'zapier_ruby/zapper_hook'

module ZapierRuby
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= ZapierRuby::Config.new
    yield(config) if block_given?
  end

  def self.configure_with(path_to_yaml_file)
    self.config ||= ZapierRuby::Config.new
    config.configure_with(path_to_yaml_file)
  end
end

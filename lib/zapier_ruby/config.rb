module ZapierRuby
  class Config
    attr_accessor :base_uri, :web_hooks, :enable_logging

    def initialize
      self.base_uri = "https://zapier.com/hooks/catch/"
      self.web_hooks = { example_webhook: "webhook_id" }
      self.enable_logging = true
    end

    def configure_with(config = {})
      self.base_url = config[:base_uri] unless config[:base_uri].nil?
      self.web_hooks = config[:web_hooks] unless config[:web_hooks].nil?
      self.enable_logging = config[:enable_logging] unless config[:enable_logging].nil?
    end

  end
end

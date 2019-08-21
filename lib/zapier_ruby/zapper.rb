module ZapierRuby
  class Zapper < Base
    attr_accessor :zap_name

    def initialize(zap_name, web_hook_id=nil)
      self.zap_name = zap_name
      self.logger = LoggerDecorator.new(config.enable_logging)
      @zap_web_hook = web_hook_id if web_hook_id
    end

    def zap(params={})
      unless zap_web_hook_id
        raise ZapierMisConfiguration, "No zap configured for #{zap_name}. Configured webhooks: #{config.web_hooks.to_s}"
      end

      logger.debug "Zapping #{zap_name} with params: #{params.to_s}"
      post_zap(params)
    end
  end
end

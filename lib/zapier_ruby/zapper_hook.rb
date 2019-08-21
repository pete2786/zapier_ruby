module ZapierRuby
  class ZapperHook < Base
    attr_accessor :opt_hash

    def initialize(opt_hash={})
      self.opt_hash = opt_hash
      self.logger = LoggerDecorator.new(config.enable_logging)
    end

    def zap(params={})
      logger.debug "Zapping #{zap_url} with params: #{params.inspect}"
      post_zap(params)
    end

    private

    def zap_url
      "#{opt_hash[:url]}"
    end
  end
end

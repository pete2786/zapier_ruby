module ZapierRuby
  class LoggerDecorator < SimpleDelegator
    attr_accessor :enable_logging

    def initialize(enable_logging)
      self.enable_logging = enable_logging
      super(ZapierRuby.config.logger)
    end

    def error(message)
      super if enable_logging
    end

    def info(message)
      super if enable_logging
    end

    def debug(message)
      super if enable_logging
    end
  end
end

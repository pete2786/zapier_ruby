module ZapierRuby
  class LoggerDecorator < SimpleDelegator
    attr_accessor :enable_logging

    def initialize(enable_logging)
      self.enable_logging = enable_logging
      super(Logger.new(STDOUT))
    end

    def error(message)
      super if enable_logging
    end

    def info(message)
      super if enable_logging
    end
  end
end
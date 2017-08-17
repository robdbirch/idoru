require 'logger'

module Idoru

  # Logger
  class Logger

    def self.create_logger(out=STDOUT, level = ::Logger::INFO)

      if out.is_a? String
        out = File.open(out, 'a+')
        out.sync = true
      end
      @logger = ::Logger.new(out)
      @logger.level = level
      @logger
    end

    def self.logger
      defined?(@logger) ? @logger : create_logger
    end

    def logger
      Logger.logger
    end

  end
end
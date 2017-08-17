require 'idoru/version'
require 'idoru/configuration'
require 'idoru/logger'

module Idoru

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.logger
    Logger.logger
  end

  def self.logger=(logger)
    Logger.logger = logger
  end

end


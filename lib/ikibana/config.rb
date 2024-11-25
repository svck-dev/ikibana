# frozen_string_literal: true

require 'yaml'
require 'erb'

module Ikibana
  class Config
    attr_reader :config

    def initialize(config_file = "config/nats.yaml")
      @config = load_config(config_file)
    end

    def self.configure(config_file = "config/nats.yaml")
      instance = new(config_file)
      yield instance if block_given?
    end

    private

    def load_config(file)
      if File.exist?(file)
        erb = ERB.new(File.read(file))
        YAML.safe_load(erb.result, aliases: true)
      else
        raise "Configuration file #{file} not found"
      end
    rescue Psych::SyntaxError => e
      raise "YAML syntax error occurred while parsing #{file}: #{e.message}"
    end
  end
end
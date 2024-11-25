# frozen_string_literal: true

require "yaml"
require "erb"
require "singleton"
require "nats/client"

module Ikibana
  # Configuration class for NATS
  class Config
    include Singleton

    attr_reader :config, :connection_string, :nats, :js
    attr_accessor :logger

    def initialize(config_file = "config/nats.yaml")
      @config = load_config(config_file)
      @connection_string = @config["connection"]["url"]
      @logger = Logger.new($stdout)
      connect
      create_streams
    rescue NATS::IO::Timeout
      @logger.error("NATS server not responding")
    rescue StandardError => e
      @logger.error("#{e.class}: Error connecting to NATS server: #{e.message}")
    end

    def self.configure(config_file = "config/nats.yaml")
      instance = new(config_file)
      yield instance if block_given?
    end

    private

    def create_streams
      @config["streams"].each do |stream|
        @js.add_stream(**stream.transform_keys(&:to_sym))
      end
    end

    def connect
      @nats ||= NATS.connect(@connection_string)
      @js ||= @nats.jetstream
      @logger.debug("Connected to NATS server at #{nats_host}")
    end

    def nats_host
      @nats_host ||= URI.parse(@connection_string).host
    end

    def load_config(file)
      raise "Configuration file #{file} not found" unless File.exist?(file)

      erb = ERB.new(File.read(file))
      YAML.safe_load(erb.result, aliases: true)
    rescue Psych::SyntaxError => e
      raise "YAML syntax error occurred while parsing #{file}: #{e.message}"
    end
  end
end

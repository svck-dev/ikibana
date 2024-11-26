# frozen_string_literal: true

require_relative "consumer"

module Ikibana
  class ApplicationConsumer
    private_class_method def self.inherited(subclass)
      super
      subclass.include Ikibana::Consumer
    end

    def initialize
      super
      ObjectSpace.define_finalizer(self, self.class.method(:destructor).to_proc)
    end

    def self.call
      new.call
    end

    def call
      return if locked?
      return run_in_sync if sync?

      run_async
    end

    private

    def run_async
      Thread.new do
        loop do
          sub.fetch(1).each do |msg|
            perform(msg)
            msg.ack
          end
        rescue NATS::IO::Timeout
          puts "Awaiting messages for #{convert_namespace_to_path}..."
        end
      end
    end

    def run_in_sync
      # code here
    end

    def sub
      @sub ||= js.pull_subscribe(convert_namespace_to_path, self.class.to_s.sub("::", "_"))
    end

    def convert_namespace_to_path
      self.class.to_s.split("::").map(&:downcase).join(".").sub("consumer", "")
    end

    def logger
      @logger = Ikibana::Config.instance.logger
    end

    def js
      @js ||= Ikibana::Config.instance.js
    end

    def locked? = cache.read("#{self.class}_locked")

    def sync? = cache.read("#{self.class}_sync")

    def cache
      @cache = Ikibana::Config.instance.cache
    end

    def perform(msg)
      raise NotImplementedError, "Subclasses must implement a `perform` method"
    end
  end
end

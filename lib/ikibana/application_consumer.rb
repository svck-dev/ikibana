# frozen_string_literal: true

require_relative 'consumer'

module Ikibana
  class ApplicationConsumer
    private_class_method def self.inherited(subclass)
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

    private

    def sub
      @sub ||= js.pull_subscribe(convert_namespace_to_path, self.class.to_s.sub("::", "_"))
    end

    def convert_namespace_to_path
      self.class.to_s.split('::').map(&:downcase).join('.').sub("consumer", "")
    end

    def logger
      @logger = Ikibana::Config.instance.logger
    end

    def js
      @js ||= Ikibana::Config.instance.js
    end

    def perform(msg)
      raise NotImplementedError, "Subclasses must implement a `perform` method"
    end
  end
end

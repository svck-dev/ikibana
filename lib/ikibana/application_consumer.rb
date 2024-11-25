# frozen_string_literal: true

require_relative 'consumer'

module Ikibana
  class ApplicationConsumer
    private_class_method def self.inherited(subclass)
      subclass.include Ikibana::Consumer
      subclass.extend Ikibana::Consumer
    end

    def self.call
      new.call
    end

    def call
      Ractor.new do
        subscription = connection.pull_subscribe(convert_namespace_to_path)
        loop do
          subscription.fetch(5).each do |msg|
            perform(msg)
          end
        end
      end
    end

    private

    def convert_namespace_to_path
      self.class.to_s.split('::').map(&:downcase).join('.')
    end

    def connection
      @connection ||= Ikibana::Config.instance.js
    end

    def perform(msg)
      raise NotImplementedError, "Subclasses must implement a `perform` method"
    end
  end
end

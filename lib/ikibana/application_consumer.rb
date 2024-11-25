# frozen_string_literal: true

module Ikibana
  class ApplicationConsumer
    def self.call(...)
      new(...).call
    end

    def initialize(...)

    end

    def call
      perform
    end

    private

    def perform
      raise NotImplementedError, "Subclasses must implement a `perform` method"
    end
  end
end

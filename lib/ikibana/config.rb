# frozen_string_literal: true

module Ikibana
  class Config
    # def initialize
    #   yield self if block_given?
    # end

    def self.configure
      instance = new
      yield instance if block_given?
    end
  end
end

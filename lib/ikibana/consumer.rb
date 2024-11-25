# frozen_string_literal: true

module Ikibana
  module Consumer
    def self.included(mod)
      mod.extend self
      mod.extend ClassMethods
      mod.include ClassMethods
    end

    module ClassMethods
      def at_most_once
        cache.write("#{self}_locked", true)
      end

      def sync(...)
        cache.write("#{self}_locked", false)
        cache.write("#{self}_sync", true)
      end

      def destructor(...)
        cache.write("#{self}_locked", false)
      end

      def cache
        Ikibana::Config.instance.cache
      end
    end
  end
end

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
        cache.write("#{self.to_s}_locked", true)
      end

      def sync(...)
        cache.write("#{self.to_s}_locked", false)
        cache.write("#{self.to_s}_sync", true)
      end

      def destructor(...)
        cache.write("#{self.to_s}_locked", false)
      end

      def cache
        Ikibana::Config.instance.cache
      end
    end
  end
end

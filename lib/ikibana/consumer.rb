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
        debugger
        Ikibana::Config.instance.cache.write("#{self.to_s}_at_most_once", true)
        "#{self.to_s}_at_most_once"
      end
    end
  end
end

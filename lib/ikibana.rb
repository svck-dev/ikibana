# frozen_string_literal: true

require_relative "ikibana/version"
require_relative "ikibana/railtie" if defined?(Rails)

module Ikibana
  class Error < StandardError; end
  # Your code goes here...
end

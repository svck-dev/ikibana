# frozen_string_literal: true

module Ikibana
  module Generators
    # This class is responsible for creating the initial files in your app folder
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __dir__)

      def create_directories
        empty_directory "app/ikibana"
        create_file "app/ikibana/.keep"
        empty_directory "spec/ikibana"
        create_file "spec/ikibana/.keep"
        template "nats.yaml.erb", "config/nats.yaml"
        template "configure.rb.erb", "config/initializers/ikibana.rb"
      end
    end
  end
end

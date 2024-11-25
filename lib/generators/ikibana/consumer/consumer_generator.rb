# frozen_string_literal: true

module Ikibana
  class ConsumerGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../../templates", __dir__)

    def create_worker
      template "consumer.rb.erb", File.join("app/ikibana", class_path, "#{file_name}_consumer.rb")
    end

    def create_worker_spec
      template "consumer_spec.rb.erb", File.join("spec/ikibana", class_path, "#{file_name}_consumer_spec.rb")
    end
  end
end

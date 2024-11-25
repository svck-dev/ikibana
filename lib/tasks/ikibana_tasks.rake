# frozen_string_literal: true

namespace :active_transaction do
  desc "version"
  task :version do
    puts "Ikibana version: #{ActiveTransaction::VERSION}"
  end
end

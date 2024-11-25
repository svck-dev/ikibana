# frozen_string_literal: true

require "rails/railtie"

module Ikibana
  # This class is a Railtie that allows the gem to be used in a Rails application.
  class Railtie < Rails::Railtie
    railtie_name :active_transaction

    rake_tasks do
      load "tasks/active_transaction_tasks.rake"
    end
  end
end

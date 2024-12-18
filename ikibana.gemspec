# frozen_string_literal: true

require_relative "lib/ikibana/version"

Gem::Specification.new do |spec|
  spec.name = "ikibana"
  spec.version = Ikibana::VERSION
  spec.authors = ["Aram"]
  spec.email = ["aramhrptn@hotmail.com"]

  spec.summary = "Ikibana is a Rails integration with NATS"
  spec.description = <<~DESC
    Ikibana is a Rails integration with NATS
    It provides a way to use NATS in Rails applications using Rails jobs as producers and workers as consumers.
  DESC
  spec.homepage = "https://github.com/svck-dev/ikibana"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nats-pure"
  spec.metadata["rubygems_mfa_required"] = "true"
end

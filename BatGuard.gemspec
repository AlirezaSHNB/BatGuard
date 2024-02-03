# frozen_string_literal: true

require_relative "lib/BatGuard/version"

Gem::Specification.new do |spec|
  spec.name = "BatGuard"
  spec.version = BatGuard::VERSION
  spec.authors = ["AlirezaSHNB"]
  spec.email = ["alirezasharifpour79@gmail.com"]

  spec.summary = "Authentication and authorization gem for Ruby with support for multiple algorithms."
  spec.description = "BatGuard is a flexible and extensible gem for handling authentication and authorization in Ruby applications. It supports various algorithms to secure user data and control access to resources."
  spec.homepage = "https://github.com/AlirezaSHNB/BatGuard"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://rubygems.org'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/AlirezaSHNB/BatGuard"
  spec.metadata["changelog_uri"] = "https://github.com/AlirezaSHNB/BatGuard/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Specify dependencies (if any)
  spec.add_dependency "bcrypt", "~> 3.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

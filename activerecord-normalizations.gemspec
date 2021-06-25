
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "activerecord-normalizations/version"

Gem::Specification.new do |spec|
  spec.name          = "activerecord-normalizations"
  spec.version       = ActiveRecord::Normalizations::VERSION
  spec.authors       = ["ccocchi"]
  spec.email         = ["cocchi.c@gmail.com"]

  spec.summary       = "Normalize your ActiveRecord models' attributes"
  spec.homepage      = "https://github.com/ccocchi/activerecord-normalizations"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.2", "< 7"
  spec.add_dependency "activesupport", ">= 4.2", "< 7"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "activerecord-nulldb-adapter", "~> 0.7.0"
end

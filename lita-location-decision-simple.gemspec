Gem::Specification.new do |spec|
  spec.name          = "lita-location-decision-simple"
  spec.version       = File.read("VERSION")
  spec.authors       = ["Mitch Dempsey","Scott M Parrish"]
  spec.email         = ["mrdempsey@gmail.com", "anithri@gmail.com"]
  spec.description   = %q{A Lita handler for making decisions about places to go}
  spec.summary       = %q{A Lita handler for making decisions about places to go}
  spec.homepage      = "https://github.com/anithri/lita-location-decision-simple"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 2.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"

  spec.metadata = { "lita_plugin_type" => "handler" }
end

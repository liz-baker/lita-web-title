Gem::Specification.new do |spec|
  spec.name          = "lita-web-title"
  spec.version       = "1.0.1"
  spec.authors       = ["Chris Baker"]
  spec.email         = ["dosman711@gmail.com"]
  spec.description   = "A Lita plugin to parse URIs and post the <title> of the page"
  spec.summary       = "A Lita plugin to parse URI titles"
  spec.homepage      = "https://github.com/dosman711/lita-web-title"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.3"
  spec.add_runtime_dependency "nokogiri", ">= 1.6.6"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end

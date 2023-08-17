require_relative 'lib/zoho_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "zoho_tools"
  spec.version       = ZohoTools::VERSION
  spec.authors       = ["Lubomir Vnenk"]
  spec.email         = ["lubomir.vnenk@zoho.com"]

  spec.summary       = %q{ZOHO auth and subscriptions}
  spec.description   = %q{ZOHO auth and subscriptions}
  spec.homepage      = "https://github.com/lubosch/zoho_tools"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lubosch/zoho_tools"
  spec.metadata["changelog_uri"] = "https://github.com/lubosch/zoho_tools"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client', '> 2'
end

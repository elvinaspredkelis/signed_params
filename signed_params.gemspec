require_relative "lib/signed_params/version"

Gem::Specification.new do |spec|
  spec.name        = "signed_params"
  spec.version     = SignedParams::VERSION
  spec.authors     = ["Elvinas Predkelis"]
  spec.email       = ["elvinas@primevise.com"]
  spec.homepage    = "https://github.com/elvinaspredkelis/signed_params"
  spec.summary     = "A Rails concern that provides automatic encoding/decoding of signed parameters to prevent tampering"
  spec.description = "A Rails concern that provides automatic encoding/decoding of signed parameters to prevent tampering"
  spec.license     = "MIT"
 	spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elvinaspredkelis/signed_params"
  spec.metadata["changelog_uri"] = "https://github.com/elvinaspredkelis/signed_params/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", "LICENCE", "Rakefile", "README.md"]
  end
end

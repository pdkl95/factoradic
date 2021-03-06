require_relative 'lib/factoradic/version'

Gem::Specification.new do |spec|
  spec.name          = "factoradic"
  spec.version       = Factoradic::VERSION
  spec.authors       = ["Brent Sanders"]
  spec.email         = ["pdkl95@gmail.com"]

  spec.summary       = %q{Factorial base integer conversion.}
  spec.description   = %q{Parse factorial base integers and generate factorial base representations of integers.}
  spec.homepage      = "https://github.com/pdkl95/factoradic"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.cert_chain = ['certs/pdkl95.pem']
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end

# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "veg_info/version"

Gem::Specification.new do |spec|
  spec.name          = "veg_info"
  spec.version       = VegInfo::VERSION
  spec.authors       = ["breadoliveoilsalt"]
  spec.email         = ["25881824+breadoliveoilsalt@users.noreply.github.com"]

  spec.summary       = %q{Scrapes data from the Cornell Extension website to provide information on certain vegetables and planting times.}
  spec.homepage      = "https://github.com/breadoliveoilsalt/veg-info-cli-app/tree/master"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "RubyGems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11.2"
  spec.add_runtime_dependency "require_all", "~> 1.4.0"
  #spec.add_runtime_dependency "open-uri"
    # uncommenting this breaks the code.  Not sure why.
  spec.add_runtime_dependency "nokogiri", "~> 1.8.1"
end

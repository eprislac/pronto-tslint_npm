# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pronto/tslint_npm/version'

Gem::Specification.new do |s|
  s.name = 'pronto-tslint_npm'
  s.version = Pronto::ESLintNpmVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Eddie Prislac','Markus Doits', 'Mindaugas Mozūras']
  s.email = 'edward.prislac@gmail.com'
  s.homepage = 'https://github.com/eprislac/pronto-tslint_npm'
  s.summary = <<-EOF
    Pronto runner for TSLint, pluggable linting utility for JavaScript and JSX
  EOF

  s.licenses = ['MIT']
  s.required_ruby_version = '>= 2.0.0'

  s.files = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(lib/|(LICENSE|README.md)$)}) }
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.require_paths = ['lib']
  s.requirements << 'tslint (in PATH)'

  s.add_dependency('pronto', '~> 0.9.1')
  s.add_development_dependency('rake', '>= 11.0', '< 13')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('byebug', '>= 9')
end

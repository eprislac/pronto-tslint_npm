# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pronto/eslint_npm/version'
require 'rake'

Gem::Specification.new do |s|
  s.name = 'pronto-eslint_npm'
  s.version = Pronto::ESLintNpmVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Markus Doits', 'Mindaugas Mozūras']
  s.email = 'markus.doits@gmail.com'
  s.homepage = 'http://github.org/doits/pronto-eslint_npm'
  s.summary = <<-EOF
    Pronto runner for ESLint, pluggable linting utility for JavaScript and JSX
  EOF

  s.licenses = ['MIT']
  s.required_ruby_version = '>= 2.0.0'
  s.rubygems_version = '1.8.23'

  s.files = FileList['LICENSE', 'README.md', 'lib/**/*']
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.require_paths = ['lib']
  s.requirements << 'eslint (in PATH)'

  s.add_dependency('pronto', '~> 0.7.0')
  s.add_development_dependency('rake', '~> 11.0')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('rspec-its', '~> 1.2')
end

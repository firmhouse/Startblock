# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'startblock/version'
require 'date'

Gem::Specification.new do |s|
  s.required_ruby_version = ">= #{Startblock::RUBY_VERSION}"
  s.authors = ['Jeroen van Baarsen', 'Firmhouse']
  s.date = Date.today.strftime('%Y-%m-%d')

  s.description = <<-HERE
Startblock is a base Rails project. It is used by Firmhouse to get a jump
start on a working app.
  HERE

  s.email = 'hello@firmhouse.com'
  s.executables = ['startblock']
  s.extra_rdoc_files = %w[README.md LICENSE]
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/firmhouse/startblock'
  s.license = 'MIT'
  s.name = 'startblock'
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.summary = "Generate a Rails app using Firmhouse's best practices."
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Startblock::VERSION

  s.add_development_dependency "minitest", "~> 5.8"
  s.add_runtime_dependency 'bundler', '~> 1.3'
  s.add_runtime_dependency 'rails', Startblock::RAILS_VERSION
  s.add_runtime_dependency 'thor', '~> 0.19'
end

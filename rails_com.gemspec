$:.push File.expand_path('../lib', __FILE__)
require 'rails_com/version'

Gem::Specification.new do |s|
  s.name = 'rails_com'
  s.version = RailsCom::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/qinmingyuan/rails_com'
  s.summary = 'Rails Engine with many common utils'
  s.description = 'Rails Engine with many common utils'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'Rakefile',
    'MIT-LICENSE',
    'README.md'
  ]
  s.require_paths = ['lib']

  s.add_dependency 'rails'
  s.add_development_dependency 'factory_bot_rails'
end

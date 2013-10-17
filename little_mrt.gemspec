Gem::Specification.new do |s|
  s.name             = 'little-mrt'
  s.version          = '0.0.1'
  s.homepage         = ''
  s.license          = 'MIT'

  s.authors          = ['Sophy Eung']
  s.email            = ['ungsophy@gmail.com']

  s.summary          = ''
  s.description      = ''

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
end

Gem::Specification.new do |s|
  s.name = 'dynarex-parser'
  s.version = '0.4.0'
  s.summary = 'dynarex-parser'
  s.authors = ['James Robertson']
  s.files = Dir['lib/dynarex-parser.rb']
  s.add_runtime_dependency('rexleparser', '~> 0.8', '>=0.8.1') 
  s.signing_key = '../privatekeys/dynarex-parser.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/dynarex-parser'
  s.required_ruby_version = '>= 2.1.2'
end

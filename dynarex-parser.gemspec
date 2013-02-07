Gem::Specification.new do |s|
  s.name = 'dynarex-parser'
  s.version = '0.2.14'
  s.summary = 'dynarex-parser'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('rexleparser') 
  s.signing_key = '../privatekeys/dynarex-parser.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end

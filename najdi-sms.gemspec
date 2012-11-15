Gem::Specification.new do |s|
  s.name        = 'najdi-sms'
  s.version     = '0.0.3'
  s.authors     = ["Jan Berdajs","Oto Brglez"]
  s.email       = ["mrbrdo@gmail.com"]
  s.homepage    = "https://github.com/mrbrdo/najdi-sms"
  s.summary     = "Send SMSes through najdi.si (slovenian site)."
  s.description = "Send SMSes through najdi.si (slovenian site)."

  #s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.files = ["lib/najdi-sms.rb"]
  #s.test_files = Dir["test/**/*"]

  s.add_dependency "mechanize"

  #s.add_development_dependency "sqlite3"

  s.executables << "najdi-sms"
end

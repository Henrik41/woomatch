# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "localtunnel"
  s.version = "0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Lindsay"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDPDCCAiSgAwIBAgIBADANBgkqhkiG9w0BAQUFADBEMRUwEwYDVQQDDAxqZWZm\nLmxpbmRzYXkxFjAUBgoJkiaJk/IsZAEZFgZ0d2lsaW8xEzARBgoJkiaJk/IsZAEZ\nFgNjb20wHhcNMTAwNTA0MjE0NzE3WhcNMTEwNTA0MjE0NzE3WjBEMRUwEwYDVQQD\nDAxqZWZmLmxpbmRzYXkxFjAUBgoJkiaJk/IsZAEZFgZ0d2lsaW8xEzARBgoJkiaJ\nk/IsZAEZFgNjb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDb1P6c\n/CN4l2pYBO0d5y7YHW3XJbj5d+5c1E9m2PcvUJ4Vjr7ISQM1SYpwixnWMBXBpzc1\nEn9YB+PYBEOOaIRh2G23aKdu7PnYQhze91qOBcHnf6LOckq25NbWQO8eaiXD3w5W\nHRXOcmzigyTYRIhXBa93eMSihWAXThcfGFKNbtKerVhytT/UVHZU3pr9gCvt9vD0\naBmwMwvDlpO72eXPr5ow3Z+VzCc51iBNC07uvR/wFQ6/lS8ULBpHI9wcdo67wdv5\nSaSZSGZCmG1pXov0Ahji7yqFMQ9oot5RDPZavZN3Fh3n6e2hdcSMlLgGkEGYaBVx\ngdQFudko7rc5cWTdAgMBAAGjOTA3MAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0G\nA1UdDgQWBBRXFNQ8j0GGeMiiPWhAlHB356JPGDANBgkqhkiG9w0BAQUFAAOCAQEA\nVzMJe10HfJtglbDah9h9lxv8uzK2uV7bXRcIbMCGEdx8cByM+cfKOnoWVDQBVPWA\nVznqXdPsrVC70PAMMTk66ro2ciyudilVEuxEl7rhaz0tj9FzNyJUHBKCD4KpGwkC\nK435qpJsHMi9k0KxY17grmsE2Hq60lFLK8ZrqgDblEAKTeaGAykMxp9KJOwAKnY2\n4lUY/SVtRuTk0YXsIPNFLYUhYt7arkJtkwWV41GWhj7PbcM5uk5sGoh0aueMzY7f\nTvklqXtUw3g3PcoJ8CZw68WaB2/MuJXUehRCZThhkBwi8bDKZzh4rtI/WEb1EgDs\nWZqts+sMhUpDxxL+p6p6bQ==\n-----END CERTIFICATE-----\n"]
  s.date = "2011-05-02"
  s.description = "instant public tunnel to your local web server"
  s.email = "jeff.lindsay@twilio.com"
  s.executables = ["localtunnel"]
  s.extra_rdoc_files = ["Rakefile", "lib/localtunnel.rb", "lib/localtunnel/tunnel.rb", "lib/localtunnel/net_ssh_gateway_patch.rb", "bin/localtunnel", "localtunnel.gemspec"]
  s.files = ["bin/localtunnel", "Rakefile", "lib/localtunnel.rb", "lib/localtunnel/tunnel.rb", "lib/localtunnel/net_ssh_gateway_patch.rb", "localtunnel.gemspec"]
  s.homepage = "http://github.com/progrium/localtunnel"
  s.require_paths = ["lib"]
  s.rubyforge_project = "localtunnel"
  s.rubygems_version = "2.0.6"
  s.summary = "instant public tunnel to your local web server"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.2.4"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 2.0.22"])
      s.add_runtime_dependency(%q<net-ssh-gateway>, [">= 1.0.1"])
    else
      s.add_dependency(%q<json>, [">= 1.2.4"])
      s.add_dependency(%q<net-ssh>, [">= 2.0.22"])
      s.add_dependency(%q<net-ssh-gateway>, [">= 1.0.1"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.2.4"])
    s.add_dependency(%q<net-ssh>, [">= 2.0.22"])
    s.add_dependency(%q<net-ssh-gateway>, [">= 1.0.1"])
  end
end

Pod::Spec.new do |s|

  s.name                       = "Punycode"
  s.version                    = "3.0.0"
  s.summary                    = "A Pure Swift library for encode and decode punycoded strings supporting iOS, macOS, tvOS, watchOS, and visionOS."
  s.homepage                   = "https://github.com/futamura/PunycodeSwift"
  s.license                    = { :type => "MIT", :file => "LICENSE" }
  s.author                     = { "Kojiro Futamura" => "gumob.dev@gmail.com" }
  s.frameworks                 = 'Foundation'
  s.requires_arc               = true
  s.source                     = { :git => "https://github.com/futamura/PunycodeSwift.git", :tag => "#{s.version}" }
  s.source_files               = "Sources/*.{swift}"
  s.osx.deployment_target      = "10.13"
  s.ios.deployment_target      = "12.0"
  s.tvos.deployment_target     = "12.0"
  s.watchos.deployment_target  = "4.0"
  s.visionos.deployment_target = "1.0"
  s.swift_version              = '5.0'

end

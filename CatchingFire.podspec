Pod::Spec.new do |s|
  s.name                  = 'CatchingFire'

  project = Xcodeproj::Project.open('CatchingFire.xcodeproj')
  target = project.targets.first
  version = target.build_settings('Debug')['CURRENT_PROJECT_VERSION']

  s.version               = version

  s.summary               = 'XCTest-style expecters to test Swift error-handling'
  s.description           = <<-eos
   CatchingFire is a Swift test framework, which helps making expectations against the error
   handling of your code. It integrates seamlessly with the expecters provided by `XCTest`.
  eos
  s.homepage              = 'https://github.com/mrackwitz/CatchingFire'
  s.social_media_url      = 'https://twitter.com/mrackwitz'
  s.author                = { 'Marius Rackwitz' => 'git@mariusrackwitz.de' }
  s.license               = 'MIT License'
  s.source                = { :git => 'https://github.com/mrackwitz/CatchingFire.git', :tag => s.version.to_s }
  s.source_files          = 'src/CatchingFire.swift'
  s.pod_target_xcconfig   = {
    "FRAMEWORK_SEARCH_PATHS" => "$(inherited) '$(PLATFORM_DIR)/Developer/Library/Frameworks'"
  }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
end

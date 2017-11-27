

Pod::Spec.new do |s|

  s.name         = "Bees"
  s.version      = "0.1.0"
  s.summary      = "Auto Layout in Swift"

  s.description  = <<-DESC
                    "Convenient auto layout framework"
                   DESC

  s.homepage     = "https://github.com/hongcaiyu/Bees"


  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Caiyu Hong" => "hongcaiyu@live.com" }

  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/hongcaiyu/Bees.git", :tag => s.version }
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.source_files  = "Bees/*.swift"

end
